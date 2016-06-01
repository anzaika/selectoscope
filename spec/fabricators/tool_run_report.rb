Fabricator(:tool_run_report) do
  run_profile_run_report
  tool {|att| att[:run_profile_run_report].run_profile.tool_for_alignment }
end
