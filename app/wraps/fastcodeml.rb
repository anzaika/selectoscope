module Fastcodeml
  def self.run(profile_report_id)
    profile_report = ProfileReport.find(profile_report_id)
    run = Fastcodeml::Run.new(group_id)
    run.execute
    report = Fastcodeml::Report.new(run)
    report.save
  end
end
