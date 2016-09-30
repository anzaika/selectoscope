class Guidance
  class Runner

    # @param[args[:vault]] A Vault object
    def initialize(args)
      @vault = args.fetch(:vault)
    end

    def execute
      @vault.execute(Guidance::EXEC, default_opts)
    end

    private

    def default_opts
      "--seqFile #{@vault.path_to(Guidance::INPUT)} " \
      "--msaProgram MAFFT " \
      "--seqType codon " \
      "--proc_num 4 " \
      "--outDir #{@vault.path_to(Guidance::OUTPUT)} "
    end
  end
end
