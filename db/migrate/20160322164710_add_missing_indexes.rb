class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :alignments, :group_id
    add_index :batches, :user_id
    add_index :codeml_results, :group_id
    add_index :fast_results, :group_id
    add_index :groups, :user_id
    add_index :groups, :batch_id
    add_index :run_reports, :group_id
    add_index :fasta_files, [:representable_as_fasta_id, :representable_as_fasta_type], name: 'fasta_filex_polymorphic'
  end
end
