class HomeController < ApplicationController

  def index
    # These variables are all presentation specific. 
    @most_improved_batting_average = BattingStat.most_improved_batting_average(2009, 2010).first[:player]
    @most_improved_fantasy_points = BattingStat.most_improved_fantasy_points(2011, 2012).take(5)
    @batting_stats_for_oak_2007 = BattingStat.for_team('OAK', 2007)
    @triple_crown_winners = (2011..2012).to_a.reverse.collect do |year|
      { 
        year: year,
        american: BattingStat.triple_crown_winner('American', year).try(:name) || 'No Winner',
        national: BattingStat.triple_crown_winner('National', year).try(:name) || 'No Winner'
      }
    end
  end

end