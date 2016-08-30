module Phyml
  def self.run(profile_report_id)
    profile_report = ProfileReport.find(profile_report_id)
    run = Phyml::Run.new(profile_report)
    run.execute
    report = Phyml::Report.new(run, profile_report)
    report.save
  end
end
