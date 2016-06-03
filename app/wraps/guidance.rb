module Guidance
  # @param fasta_string [String]
  def self.run(fasta_string, tool_id)
    run = Guidance::Run.new(fasta_string)
    run.execute
    report = Guidance::Report.new(run, tool_id)
    report.save
  end
end
