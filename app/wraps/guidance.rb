class Guidance
  PROGRAM = "Guidance".freeze
  EXEC = "perl /usr/src/guidance/guidance-2.01/www/Guidance/guidance.pl".freeze
  INPUT = "fasta.fasta".freeze
  OUTPUT = "output".freeze
  ALIGNMENT_FILENAME = "#{OUTPUT}/MSA.MAFFT.aln.With_Names".freeze
  SCORES_FILENAME = "#{OUTPUT}/MSA.MAFFT.Guidance2_res_pair_col.scr".freeze
  RESULT = "#{OUTPUT}/MSA.MAFFT.Without_low_SP_Col.With_Names".freeze

  attr_reader :vault, :args

  def initialize
    @vault = Vault.new
  end

  # @param[args[:input]] A String with FASTA
  def execute(args)
    @input = args.fetch(:input)
    Preparer.new({vault: @vault, input: @input}).execute
    Runner.new({vault: @vault}).execute
    Outputter.new({vault: @vault}).execute
  end
end
