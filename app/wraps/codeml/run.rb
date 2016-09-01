module Codeml
  class Run < RunBase
    PROGRAM = "PAML-codeml".freeze
    EXEC = "cdmw.py".freeze
    ALIGNMENT = "aligned.fasta".freeze
    TREE = "tree.nwk".freeze
    OUTPUT = "output.out".freeze

    def version
      ""
    end

    def args
      @args ||= "--noisy 9 --method 1 --preset M1 #{v.path_to(ALIGNMENT)} #{v.path_to(TREE)} #{v.path_to(OUTPUT)}"
    end

    def setup_files
      copy_encoded_alignment
      copy_encoded_tree
    end

    def copy_encoded_alignment
      fasta = @profile_report.alignment.to_molphy_string
      encoded = @profile_report.group.enigma.encode_string(fasta)
      encoded_clean = encoded.gsub("-", "N")
      v.write_to_file(encoded_clean, ALIGNMENT)
    end

    def copy_encoded_tree
      tree = @profile_report.tree.newick_without_inner_node_names
      encoded = @profile_report.group.enigma.encode_string(tree)
      v.write_to_file(encoded, TREE)
    end
  end
end
