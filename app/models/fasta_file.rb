class RepeatingIdentifiersValidator < ActiveModel::Validator
  def validate(record)
    content = File.open(record.file.queued_for_write[:original].path).read
    record.errors.add(:file, "repeating identifiers") if count(content) > 0
  end

  def count(content)
    Bio::Alignment::MultiFastaFormat
      .new(content)
      .alignment
      .keys
      .count {|k| k.class == Fixnum }
  end
end

class FastaFile < ActiveRecord::Base
  belongs_to :representable_as_fasta, polymorphic: true
  has_attached_file :file,
                    path: ":rails_root/public/fasta_file/:id/:filename",
                    url:  "/fasta_file/:id/:filename"

  validates_attachment :file,
                       content_type: {content_type: ["application/octet-stream", "text/plain"]}

  validates_with RepeatingIdentifiersValidator

  def to_bioruby_alignment_object
    Bio::Alignment::MultiFastaFormat
      .new(read_file)
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

  private

  def read_file
    File.open(file.path).read
  end
end
