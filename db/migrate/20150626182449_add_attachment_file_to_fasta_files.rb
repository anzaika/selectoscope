class AddAttachmentFileToFastaFiles < ActiveRecord::Migration
  def self.up
    change_table :fasta_files do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :fasta_files, :file
  end
end
