Fabricator(:player) do
  first_name Faker::Name.first_name
  last_name Faker::Name.last_name
  birth_year 1978
  code 'NMB'
end