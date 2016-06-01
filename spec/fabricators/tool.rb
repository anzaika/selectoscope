Fabricator(:tool) do
  name { sequence(:tool_names) { |i| Faker::Lorem.word + i.to_s }}
  class_name { sequence(:tool_class_names) { |i| Faker::Lorem.word + i.to_s }}
  type { Tool.types.sample }
end

Fabricator(:tool_for_alignment, from: :tool) do
  type { Tool::FOR_ALIGNMENT }
end

Fabricator(:tool_for_tree, from: :tool) do
  type { Tool::FOR_TREE }
end

Fabricator(:tool_for_selection, from: :tool) do
  type { Tool::FOR_SELECTION }
end
