module Mafft
  # @param fasta_string [String]
  def self.run(fasta_string, tool_id)
    run = Mafft::Run.new(fasta_string)
    run.execute
    report = Mafft::Report.new(run, tool_id)
    report.save
  end
end
