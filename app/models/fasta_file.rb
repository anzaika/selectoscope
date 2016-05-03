# == Schema Information
#
# Table name: fasta_files
#
#  id                          :integer          not null, primary key
#  representable_as_fasta_type :string(255)
#  representable_as_fasta_id   :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  file_file_name              :string(255)
#  file_content_type           :string(255)
#  file_file_size              :integer
#  file_updated_at             :datetime
#

class FastaFile < ActiveRecord::Base
  belongs_to :representable_as_fasta, polymorphic: true
  has_attached_file :file,
                    path: ":rails_root/storage/fasta_files/:id/:basename.:extension",
                    url:  "/fasta_file/:id/:filename"

  validates_attachment :file,
                       content_type: {content_type: ["application/octet-stream", "text/plain"]}

  def to_bioruby_alignment_object
    Bio::Alignment::MultiFastaFormat
      .new(to_fasta_string)
      .alignment
  end

  def to_molphy_text_format(newline_after_this_many_bases: 100_00)
    to_bioruby_alignment_object
      .output_molphy(width: newline_after_this_many_bases)
  end

  def to_phylip_text_format
    to_bioruby_alignment_object
      .output_phylip
  end

  def to_array_of_two_element_arrays_with_desc_and_seq
    ali = to_bioruby_alignment_object
    keys = ali.keys
    keys = keys.map {|k| k.class == Fixnum ? keys[k - 1] : k }
    keys.zip(ali.entries)
  end

  def to_hash
    to_array_of_two_element_arrays_with_desc_and_seq.to_h
  end

  def each_seq_with_description(&block)
    to_array_of_two_element_arrays_with_desc_and_seq
      .each do |desc, seq|
        block.yield(desc, seq)
      end
  end

  def to_fasta_string
    File.open(file.path).read
  end
end
