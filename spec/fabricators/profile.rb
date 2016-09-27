Fabricator(:profile) do
  name { Faker::Lorem.paragraph.split(" ").sample }
  tool_for_alignment_id { Fabricate(:tool).id }
  tool_for_filtering_id { Fabricate(:tool).id }
  tool_for_tree_id { Fabricate(:tool).id }
  tool_for_selection_id { Fabricate(:tool).id }
  user
end
