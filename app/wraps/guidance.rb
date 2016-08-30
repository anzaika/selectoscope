module Guidance
  # @param fasta_string [String]
  def self.run(profile_report_id)
    profile_report = ProfileReport.find(profile_report_id)
    run = Guidance::Run.new(profile_report)
    run.execute
    report = Guidance::Report.new(run, profile_report)
    report.save
  end
end
