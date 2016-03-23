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
