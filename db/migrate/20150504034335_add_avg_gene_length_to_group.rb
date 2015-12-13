class AddAvgGeneLengthToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :avg_gene_length, :integer
  end
end
