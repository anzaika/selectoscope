class RemoveLimitOnFastaFieldInAlignment < ActiveRecord::Migration
  def change
    change_column :alignments, :fasta, :text, limit: nil
  end
end
