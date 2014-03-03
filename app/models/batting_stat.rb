class BattingStat < ActiveRecord::Base

  ## Associations

  belongs_to :player
  belongs_to :team

  ## Validations

  validates :player_id, :team_id, :year, presence: true
  validates :player_id, uniqueness: { scope: [ :team_id, :year ] }

  ## Scopes

  scope :for_league, lambda{|league, year|
    includes(:team, :player).where('teams.league = ? AND batting_stats.year = ?', league, year).
      order('players.last_name, players.first_name').references(:teams)
  }

  scope :for_team, lambda{|team_code, year|
    includes(:team, :player).where('teams.code = ? AND batting_stats.year = ?', team_code, year).
      order('players.last_name, players.first_name').references(:teams)
  }

  scope :min_at_bats, lambda{|min_at_bats, start_year, end_year|
    where('at_bats >= ? AND year IN (?)', min_at_bats, [ start_year, end_year ]).
      order('player_id, year desc')
  }

  ## Class Methods

  class << self

    def most_improved_batting_average(start_year, end_year, min_at_bats = 200)
      most_improved :batting_average, start_year, end_year, min_at_bats
    end

    def most_improved_fantasy_points(start_year, end_year, min_at_bats = 500)
      most_improved :fantasy_points, start_year, end_year, min_at_bats
    end

    def triple_crown_winner(league, year)
      # full major season consists of 162 games, 162 multiplied by 3.1 equals 502
      # 502 is the required minimum at_bats to with the triple crown
      season_games = 162
      at_bats_per_game = 3.1

      stats = for_league(league, year).where('at_bats >= ?', season_games * at_bats_per_game).load

      candidates = []
      candidates << stats.sort_by(&:batting_average).last
      candidates << stats.sort_by(&:homeruns).last
      candidates << stats.sort_by(&:rbis).last
      candidates.compact!

      if candidates.length > 0 && candidates.group_by(&:player_id).first.last.count == 3
        candidates.first.player
      end
    end

  private

    def most_improved(stat, start_year, end_year, min_at_bats)
      records = min_at_bats(min_at_bats, start_year, end_year).includes(:player).
        group_by(&:player_id).select{|r, s| s.count > 1 }
      records.collect{|pid, stats|
        { player: stats.first.player, value: ( stats.first.send(stat) * 1.0 / stats.last.send(stat) ).to_f }
      }.sort_by{|r| r[:value] }.reverse
    end

  end

  ## Instance Methods

  def fantasy_points
    [ ( homeruns.to_i * 4 ), rbis.to_i, stolen_bases.to_i ].sum - caught_stealing.to_i
  end

  def batting_average
    n = at_bats.to_f
    n > 0 ? ( hits.to_f / n ) : 0
  end

  def slugging_percentage
    n = at_bats.to_f
    n > 0 ? ([
      ( hits.to_i - doubles.to_i - triples.to_i - homeruns.to_i ),
      ( 2 * doubles.to_i ),
      ( 3 * triples.to_i ),
      ( 4 * homeruns.to_i )
    ].sum / n ).round(3) : 0
  end

end
