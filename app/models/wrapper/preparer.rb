class Wrapper
  class Preparer
    # @param[args[:input]] A Hash with input strings
    # @param[args[:vault]] A Vault object
    def initialize(args)
      @input = args.fetch(:input)
      @vault = args.fetch(:vault)
    end

    def execute
      @input.each do |k,v|
        @vault.write_to_file(v, self.class.parent.const_get("INPUT_#{k.upcase}"))
      end
    end
  end
end
