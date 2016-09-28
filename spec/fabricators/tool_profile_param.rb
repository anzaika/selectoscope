Fabricator(:tool_profile_param) do
  tool_profile_id { Faker::Number.number(4)}
  key { "-" + Faker::Lorem.word }
  value { Faker::Lorem.word }
end
