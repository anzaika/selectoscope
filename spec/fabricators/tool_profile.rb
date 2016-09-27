Fabricator(:tool_profile) do
  name { Faker::Lorem.paragraph.split(" ").sample }
  tool
  tool_profile_params(count: 5)
end
