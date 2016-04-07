Fabricator(:tree) do
  treeable { Fabricate(:group) }
  tree
end
