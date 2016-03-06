module Wrap
class Mafft

  attr_reader :alignment, :run_report, :succ

  EXEC = "mafft-linsi"

  def initialize(fasta_file_object)
    @v = Vault.new
    @ff = fasta_file_object
  end

  def execute
    setup_files
    run
    assess_run
    clear_temp_files
  end

  private

  def setup_files
    @v.add(@ff.file, 'sequences.fasta')
  end

  def assemble_arguments
    "#{@v.path_to('sequences.fasta')} > #{@v.path_to('aligned.fasta')}"
  end

  def run
    @v.run(EXEC, assemble_arguments)
  end

  def assess_run
    @succ = FileTest.exist?(@v.path_to('aligned.fasta'))
    create_run_report(@succ)
    @succ && create_alignment && link_alignment_to_run_report
  end

  def create_alignment
    fasta_file = FastaFile.create(file: File.open(@v.path_to('aligned.fasta')))
    @alignment = Alignment.create()
    @alignment.fasta_file = fasta_file
  end

  def link_alignment_to_run_report
    RunnableRunReportAssociation
      .create(
        runnable_type: 'alignment',
        runnable_id: @alignment.id,
        run_report_id: @run_report.id)
  end

  def create_run_report(successful)
    @run_report =
      RunReport.create(
        stdout: File.open(@v.path_to('stdout')),
        stderr: File.open(@v.path_to('stderr')),
        directory_snapshot: Dir[@v.dir],
        program: EXEC,
        params: assemble_arguments,
        successful: successful
    )
  end

  def clear_temp_files
    @v.destroy
  end

end
end
