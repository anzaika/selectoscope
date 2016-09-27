Fabricator(:tool) do
  name { sequence(:tool_names) { |i| Faker::Lorem.word + i.to_s }}
  class_name { sequence(:tool_class_names) { |i| Faker::Lorem.word + i.to_s }}
  job { Tool::JOBS.sample }
end
