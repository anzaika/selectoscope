class Wrapper
  class Runner
    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
      @report = args.fetch(:report)
    end

    def execute
      @report.params = default_opts
      @vault.execute(self.class.parent::EXECUTABLE, default_opts)
    end

    def default_opts
      raise "Needs to be defined"
    end
  end
end
