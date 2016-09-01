module Fastcodeml
  class Run < RunBase
    PROGRAM   = "fastcodeml".freeze
    EXEC      = "fast".freeze
    ALIGNMENT = "aligned.phy".freeze
    TREE      = "tree.nwk".freeze
    OUTPUT    = "output.out".freeze

    def version
      ""
    end

    def args
      @args ||=
        " --no-pre-stop"               \
        " -nt 4"                       \
        " -v 4"                        \
        " -p k=#{codeml.k}"            \
        " -ou #{v.path_to(OUTPUT)}"   \
        " #{v.path_to(TREE)}"         \
        " #{v.path_to(ALIGNMENT)}"
    end

    def setup_files
      copy_encoded_alignment
      copy_encoded_tree
    end

    def codeml
      @codeml ||= @profile_report.codeml_result
    end

    def copy_encoded_alignment
      fasta = @profile_report.alignment.to_molphy_string
      encoded = @profile_report.group.enigma.encode_string(fasta)
      v.write_to_file(encoded, ALIGNMENT)
    end

    def copy_encoded_tree
      tree = codeml.tree.newick
      encoded = @profile_report.group.enigma.encode_string(tree)
      v.write_to_file(encoded, TREE)
    end
  end
end
