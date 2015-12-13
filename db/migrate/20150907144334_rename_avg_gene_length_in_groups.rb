class RenameAvgGeneLengthInGroups < ActiveRecord::Migration
  def change
    rename_column :groups, :avg_gene_length, :avg_sequence_length
  end
end
