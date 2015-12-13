class ChangeFastaToBlobInAlignments < ActiveRecord::Migration
  def change
    change_column :alignments, :fasta, :blob
  end
end
