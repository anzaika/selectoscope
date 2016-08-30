Fabricator(:fast_result) do
  run_report { Fabricate(:run_report_fast) }
end
