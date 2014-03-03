require 'csv'

def or_zero(value)
  value.blank? ? 0 : value 
end

NATIONAL_LEAGUE_CODES = %w(ATL CHN CIN COL LAN MIA MIL NYN PHI PIT ARI SDN SLN SFN WAS)

# clean the current data
BattingStat.destroy_all
Team.destroy_all
Player.destroy_all

# import the players from csv
CSV.foreach("#{Rails.root}/db/data/Master-small.csv", headers: true, header_converters: :symbol) do |row|
  begin
    Player.where(
      first_name: row[:namefirst],
      last_name:  row[:namelast],
      code:       row[:playerid],
      birth_year: row[:birthyear]
    ).first_or_create!
  rescue ActiveRecord::RecordInvalid => e
    # skip rows that do not validate because it gives us a chance to fix the data
    puts "Skipping: #{row.inspect}"
    puts "  Reason: #{e.message}\n"
  end
end

# import the batting stats from csv
CSV.foreach("#{Rails.root}/db/data/Batting-07-12.csv", headers: true, header_converters: :symbol) do |row|
  league = NATIONAL_LEAGUE_CODES.include?(row[:teamid]) ? 'National' : 'American'
  team   = Team.where(code: row[:teamid], league: league).first_or_create!
  player = Player.where(code: row[:playerid]).first!

  begin
    BattingStat.create!(
      player:           player,
      team:             team, 
      year:             row[:yearid],
      games_played:     or_zero(row[:g]),
      at_bats:          or_zero(row[:ab]),
      runs:             or_zero(row[:r]),
      hits:             or_zero(row[:h]),
      doubles:          or_zero(row[:'2b']),
      triples:          or_zero(row[:'3b']),
      homeruns:         or_zero(row[:hr]),
      rbis:             or_zero(row[:rbi]), 
      stolen_bases:     or_zero(row[:sb]),
      caught_stealing:  or_zero(row[:cs])
    )
  rescue ActiveRecord::RecordInvalid => e
    # skip rows that do not validate because it gives us a chance to fix the data
    puts "Skipping: #{row.inspect}"
    puts "  Reason: #{e.message}\n"
  end
end