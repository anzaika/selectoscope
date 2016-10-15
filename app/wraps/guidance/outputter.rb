class Guidance
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
      update_report
      @result
    end

    private

    def process_output
      @result.alignment = resulting_alignment
    end

    def update_report
      @report.successful = run_successful?
      @result.successful = run_successful?
    end

    def resulting_alignment
      run_successful? ? Silencer.new({vault: @vault}).execute : nil
    end

    def run_successful?
      FileTest.exist?(@vault.path_to(ALIGNMENT)) &&
      FileTest.exist?(@vault.path_to(SCORES))
    end
  end
end
