Fabricator(:tool) do
  name { Faker::Lorem.word }
  class_name { Faker::Lorem.word }
  type { Tool.types.sample }
end
