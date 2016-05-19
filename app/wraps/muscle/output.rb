module Muscle
  class Output
    def initialize(spec)
      @alignment = spec.result_path
    end

    def process
      return nil unless File.exist?(@alignment)
      Alignment.create(fasta: File.open(@alignment).read, meta: 'raw')
    end
  end
end
