module Wrap
class Mafft::Report

  attr_reader :run_report, :alignment

  def initialize(vault, mafft_run)
    @v = vault
    @run = mafft_run
  end

  def save
    create_run_report
    create_alignment if run_successful?
    clear_temp_files
  end

  def run_successful?
    @run_successful ||=
      FileTest.exist?(@run.path_to_alignment) &&
      FileTest.exist?(@v.path_to('stdout')) &&
      FileTest.exist?(@v.path_to('stderr'))
  end

  private

  def create_run_report
    save_out_files
    save_run_report
    @run_report.text_files << @stdout
    @run_report.text_files << @stderr
  end

  def save_out_files
    @stdout = TextFile.create(file: File.open(@v.path_to('stdout')))
    @stderr = TextFile.create(file: File.open(@v.path_to('stderr')))
  end

  def save_run_report
    @run_report =
      RunReport.create(
        directory_snapshot: @v.file_list,
        program: Mafft::Run::EXEC,
        params: @run.args,
        successful: run_successful?)
  end

  def create_alignment
    fasta_file = FastaFile.create(file: File.open(@run.path_to_alignment))
    @alignment = Alignment.create(meta: 'original', fasta_file: fasta_file)
    @alignment.run_reports << @run_report
  end

  def clear_temp_files
    @v.destroy
  end

end
end
