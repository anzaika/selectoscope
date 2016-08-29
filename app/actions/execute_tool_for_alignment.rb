class ExecuteToolForAlignment
  # @param rprr_id [Integer] ID of ProfileReport record
  def initialize(rprr_id)
    @rprr = ProfileReport.find(rprr_id)
    execute
  end

  def execute
    execute_wrapper
    decode_all_files_in_tool_run_report
    save_output_alignment if tool_run_successful?
  end

  def input_fasta_string
    @input_fasta_string ||= @rprr.group.fasta_file.to_fasta_string
    puts @input_fasta_string.inspect
    @input_fasta_string
  end

  def enigma
    @enigma ||= Identifier::Enigma.new(@rprr.group.id)
  end

  def encoded_input_fasta_string
    enigma.encode_string(input_fasta_string)
  end

  def execute_wrapper
    @tool_run_report =
      Guidance.run(input_fasta_string, @rprr.tool_for_alignment.id)
    @tool_run_report.update_attribute(:profile_report_id, @rprr.id)
  end

  def tool_run_successful?
    @tool_run_report.successful
  end

  def decode_all_files_in_tool_run_report
    @tool_run_report.decode_all_text_files
  end

  def save_output_alignment
    filepath = @tool_run_report.get_file("output_alignment").file.path
    fasta_file = FastaFile.create(file: File.open(filepath), )
    alignment = Alignment.create(fasta_file: fasta_file)
    @rprr.alignment = alignment
  end
end
