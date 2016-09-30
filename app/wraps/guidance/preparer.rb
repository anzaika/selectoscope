class Guidance
  class Preparer

    # @param[args[:input]] A String with FASTA
    # @param[args[:vault]] A Vault object
    def initialize(args)
      @input = args.fetch(:input)
      @vault = args.fetch(:vault)
    end

    def execute
      @vault.write_to_file(@input, Guidance::INPUT)
    end
  end
end
