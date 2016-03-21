class RemoveObsoleteColumns < ActiveRecord::Migration
  def change
    remove_column :codeml_results, :stdout
    remove_column :codeml_results, :stderr
    remove_column :codeml_results, :output
    remove_column :codeml_results, :tree
    remove_column :fast_results, :stdout
    remove_column :fast_results, :stderr
    remove_column :identifiers, :short_name
    remove_column :identifiers, :sequences_count
    remove_column :run_reports, :stdout
    remove_column :run_reports, :stderr
    drop_table :sequences
    remove_column :trees, :name
    remove_column :alignments, :fasta
  end
end
