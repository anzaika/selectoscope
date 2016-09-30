class AlignmentToolExecutor
  def initialize(args)
    @executor = args.fetch(:profile_executor)
    @tool = @executor.profile.tool_for(:alignment)
    @wrapper = @tool.wrapper.new
  end

  def execute
    path_to_alignment_or_nil = @wrapper.execute({input: encode_input})
    return nil unless path_to_alignment_or_nil
    fasta_file = FastaFile.create(file: File.open(path_to_alignment_or_nil), )
    Alignment.create(fasta_file: fasta_file)
  end

  def encode_input
    @executor
       .group
       .enigma
       .encode_string(@executor.group.fasta_file.to_fasta_string)
  end
end
