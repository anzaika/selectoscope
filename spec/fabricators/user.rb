Fabricator(:user) do
  first_name { Faker::Lorem.word }
  last_name { Faker::Lorem.word }
  password { Faker::Internet.password }
  role "user"
  email { Faker::Internet.email }
end
