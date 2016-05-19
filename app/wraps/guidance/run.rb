module Guidance
  class Run < RunBase
    PROGRAM = "Guidance".freeze
    EXEC = "perl /usr/src/guidance/guidance.v2.01/www/Guidance/guidance.pl".freeze
    FASTA = "fasta.fasta".freeze
    OUTPUT = "output".freeze

    def version
      ""
    end

    def args
      @args ||=
        "--seqFile #{@v.path_to(FASTA)} " \
        "--msaProgram MAFFT --seqType codon " \
        "--outDir #{@v.path_to(OUTPUT)} "
    end

    def setup_files
      @v.add(@g.fasta_file.file.path, FASTA)
    end
  end
  
end