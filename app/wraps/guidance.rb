class Guidance
  PROGRAM = "Guidance".freeze
  EXEC = "perl /usr/src/guidance/guidance-2.01/www/Guidance/guidance.pl".freeze
  INPUT = "fasta.fasta".freeze
  OUTPUT = "output".freeze
  ALIGNMENT= "#{OUTPUT}/MSA.MAFFT.aln.With_Names".freeze
  SCORES= "#{OUTPUT}/MSA.MAFFT.Guidance2_res_pair_col.scr".freeze

  THRESHOLD = 0.86

  attr_reader :vault, :args

  def initialize
    @vault = Vault.new
    @report = ToolReport.new(program: PROGRAM, exec: EXEC, start: Time.now)
  end

  # @param[args[:input]] A String with FASTA
  def execute(args)
    @input = args.fetch(:input)
    Preparer.new({vault: @vault, input: @input}).execute
    Runner.new({vault: @vault, report: @report}).execute
    Outputter.new({vault: @vault, report: @report}).execute
  end
end
