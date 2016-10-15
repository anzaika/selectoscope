class Phyml
  PROGRAM = "PhyML".freeze
  EXEC = "phyml".freeze
  INPUT = "aligned.phylip".freeze
  OUTPUT = "aligned.phylip_phyml_tree".freeze

  attr_reader :vault, :args

  def initialize
    @vault = Vault.new
    @report = ToolReport.new(program: PROGRAM, exec: EXEC, start: Time.now)
  end

  def execute(args)
    @input = args.fetch(:input)
    Preparer.new({vault: @vault, input: @input}).execute
    Runner.new({vault: @vault, report: @report}).execute
    Outputter.new({vault: @vault, report: @report}).execute
  end
end
