class Wrapper
  class Outputter
    # @param[args[:vault]] A Vault object
    # @param[args[:report]] A ToolReport object
    def initialize(args)
      @result = OpenStruct.new
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      process_output if run_successful?
      save_report
      save_logs
      @result
    end

    def save_logs
      TextFile.create(file:         File.open(@vault.path_to_stdout),
                      meta:         "stdout",
                      textifilable: @report)

      TextFile.create(file:         File.open(@vault.path_to_stderr),
                      meta:         "stderr",
                      textifilable: @report)
    end

    def process_output
      @result.output = File.open(@vault.path_to(self.class.parent::OUTPUT)).read
    end

    def save_report
      @report.successful = run_successful?
      @result.successful = run_successful?
      @result.report = @report
      @report.save
    end

    def run_successful?
      raise "Needs to be defined"
    end
  end
end
