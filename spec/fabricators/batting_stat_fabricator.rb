Fabricator(:batting_stat) do
  player          { Player.last || Fabricate(:player) }
  team            { Team.last || Fabricate(:team) }
  year            '2007'
  games_played    1
  at_bats         1
  runs            1
  hits            1
  doubles         1
  triples         1
  homeruns        1
  rbis            1
  stolen_bases    1
  caught_stealing 1
end