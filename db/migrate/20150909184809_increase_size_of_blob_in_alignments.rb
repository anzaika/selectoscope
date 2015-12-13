class IncreaseSizeOfBlobInAlignments < ActiveRecord::Migration
  def change
    change_column :alignments, :fasta, :binary, limit: 200.megabyte
  end
end
