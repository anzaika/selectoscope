module Fastcodeml
  def self.run(profile_report_id)
    profile_report = ProfileReport.find(profile_report_id)
    run = Fastcodeml::Run.new(profile_report)
    run.execute
    report = Fastcodeml::Report.new(run, profile_report)
    report.save
  end
end
