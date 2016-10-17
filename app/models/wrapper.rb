# Abstract class
class Wrapper
  attr_reader :vault, :args

  def initialize
    @vault = Vault.new
    @report = ToolReport.new(program: self.class::PROGRAM, exec: self.class::EXECUTABLE, start: Time.now)
  end

  def execute(args)
    @input = args.fetch(:input)
    self.class::Preparer.new({vault: @vault, input: @input}).execute
    self.class::Runner.new({vault: @vault, report: @report}).execute
    self.class::Outputter.new({vault: @vault, report: @report}).execute
  end
end
