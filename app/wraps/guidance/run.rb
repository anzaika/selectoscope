module Guidance
  class Run < RunBase
    PROGRAM = "Guidance".freeze
    EXEC = "perl /usr/src/guidance/guidance-2.01/www/Guidance/guidance.pl".freeze
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
      v.write_to_file(encoded_fasta_string, FASTA)
    end

    def encoded_fasta_string
      @profile_report
        .group
        .enigma
        .encode_string(
          @profile_report.group.fasta_file.to_fasta_string)
    end
  end
end
