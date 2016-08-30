Fabricator(:profile_report) do
  group
  profile
  after_save {group.profiles << profile}
end
