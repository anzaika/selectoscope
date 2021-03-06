module Phyml
  class Run < RunBase
    PROGRAM = "PhyML".freeze
    EXEC = "phyml".freeze
    ALIGNMENT = "aligned.phylip".freeze
    OUTPUT = "aligned.phylip_phyml_tree".freeze

    def version
      ""
    end

    def args
      @args ||= "-q -i #{@v.path_to(ALIGNMENT)}"
    end

    def setup_files
      copy_encoded_alignment
    end

    def copy_encoded_alignment
      fasta = @profile_report.alignment.to_molphy_string
      encoded = @profile_report.group.enigma.encode_string(fasta)
      v.write_to_file(encoded, ALIGNMENT)
    end
  end
end
