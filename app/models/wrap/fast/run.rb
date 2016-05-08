module Wrap
  class Fast::Run < Wrap::Run
    PROGRAM   = "Fastcodeml".freeze
    EXEC      = "fast".freeze
    ALIGNMENT = "aligned.phy".freeze
    TREE      = "tree.nwk".freeze
    OUTPUT    = "output.out".freeze

    def version
      ""
    end

    def args
      @args ||=
        " -nt 1"                       \
        " -nt 4"                       \
        " -p w0=#{codeml.w0}"          \
        " -p k=#{codeml.k}"            \
        " -p p0=#{codeml.p0}"          \
        " -p p1=#{codeml.p1}"          \
        " -p w2=#{codeml.w1}"          \
        " -ou #{@v.path_to(OUTPUT)}"   \
        " #{@v.path_to(TREE)}"         \
        " #{@v.path_to(ALIGNMENT)}"
    end

    def setup_files
      copy_encoded_alignment
      copy_encoded_tree
    end

    def codeml
      @codeml ||= @g.codeml_result
    end

    def copy_encoded_alignment
      fasta = @g.alignment.to_molphy_string
      encoded = Identifier::Enigma.new(@g.id).encode_string(fasta)
      @v.write_to_file(encoded, ALIGNMENT)
    end

    def copy_encoded_tree
      tree = codeml.tree.newick
      encoded = Identifier::Enigma.new(@g.id).encode_string(tree)
      @v.write_to_file(encoded, TREE)
    end
  end
end
