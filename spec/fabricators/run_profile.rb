Fabricator(:run_profile) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.paragraph }
  user
end
