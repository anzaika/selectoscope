Fabricator(:profile) do
  name { Faker::Lorem.paragraph.split(" ").sample }
  tool_for_alignment_id { Fabricate(:tool_for_alignment).id }
  tool_for_tree_id { Fabricate(:tool_for_tree).id }
  tool_for_selection_id { Fabricate(:tool_for_selection).id }
  user
end
