module Codeml
  # @param fasta_string [String]
  def self.run(profile_report_id)
    profile_report = ProfileReport.find(profile_report_id)
    run = Codeml::Run.new(profile_report)
    run.execute
    report = Codeml::Report.new(run, profile_report)
    report.save
  end
end
