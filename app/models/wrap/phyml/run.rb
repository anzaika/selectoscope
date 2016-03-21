module Wrap
class Phyml::Run < Run

  EXEC = 'phyml'
  ALIGNMENT = "aligned.phylip"
  OUTPUT = "aligned.phylip_phyml_tree"

  def args
    @args ||= "-q -i #{@v.path_to(ALIGNMENT)}"
  end

  def setup_files
    copy_encoded_alignment
  end

  def copy_encoded_alignment
    fasta = @g.alignment.to_molphy_string
    encoded = Identifier.encode_string(@g.id, fasta)
    @v.write_to_file(encoded, ALIGNMENT)
  end

end
end
