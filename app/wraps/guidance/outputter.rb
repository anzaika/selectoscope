class Guidance
  class Outputter
    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
    end

    def execute
      result_path = @vault.path_to(Guidance::RESULT)
      FileTest.exist?(result_path) ? result_path : nil
    end
  end
end
