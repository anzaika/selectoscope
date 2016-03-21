class Group::TransformIdentifiers

  def initialize(group_id)
    @g = Group.find(group_id)
  end

  def transform
    gather_original_identifiers
    tranform_original_identifiers
    create_map
    rewrite_fasta_file
  end

  def gather_original_identifiers
    @orig_ids =
      @g.fasta_file
        .to_array_of_two_element_arrays_with_desc_and_seq
        .map(&:first)
  end

  def tranform_original_identifiers
    @trans_ids = @orig_ids.map { |i| Identifier.transform(i) }
  end

  def create_map
    @map = @orig_ids.zip(@trans_ids)
  end

  def rewrite_fasta_file
    fasta = @g.fasta_file.to_fasta_string
    new_fasta = @map.inject(fasta) { |a, e| a.gsub(e.first, e.last) }
    File.open(@g.fasta_file.file.path, 'w') { |f| f << new_fasta }
  end

end
