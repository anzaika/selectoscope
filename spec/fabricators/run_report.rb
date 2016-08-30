Fabricator(:run_report) do
  program { Faker::Lorem.word }
  successful true
  group
end

Fabricator(:run_report_fast, from: :run_report) do
  program "Fastcodeml"
  after_create { |run_report|
    Fabricate(
      :text_file,
      textifilable: run_report,
      meta:         "output",
      file:         File.open(File.join(Rails.root, "spec/fixtures/fast_output/output.out"))
    )
    Fabricate(
      :text_file,
      textifilable: run_report,
      meta:         "stdout",
      file:         File.open(File.join(Rails.root, "spec/fixtures/fast_output/stdout.out"))
    )
  }
end
