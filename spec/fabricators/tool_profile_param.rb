Fabricator(:tool_profile_param) do
  tool_profile_id { Faker::Number.number(4)}
  key { Faker::Lorem.paragraph.split(" ").sample }
  value { Faker::Number.decimal(12, 8) }
end
