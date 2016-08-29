Fabricator(:tool_run_report) do
  profile_report
  tool {|att| att[:profile_report].profile.tool_for_alignment }
end
