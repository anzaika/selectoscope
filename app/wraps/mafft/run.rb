module Mafft
  class Run < RunBase
    PROGRAM = "MAFFT".freeze
    EXEC = "mafft-linsi".freeze
    FASTA = "fasta.fasta".freeze
    OUTPUT = "output.out".freeze

    # @param fasta_string [String]
    def initialize(fasta_string)
      @fasta_string = fasta_string
    end

    def version
      ""
    end

    def args
      @args ||= "#{@v.path_to(FASTA)} > #{@v.path_to(OUTPUT)}"
    end

    def setup_files
      v.add(@g.fasta_file.file.path, FASTA)
    end
  end
end
