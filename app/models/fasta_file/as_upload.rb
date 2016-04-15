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

class FastaFile::RepeatingIdentifiersValidator < ActiveModel::Validator
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

class FastaFile::AsUpload < ActiveType::Record[FastaFile]
  validates_with FastaFile::RepeatingIdentifiersValidator
end
