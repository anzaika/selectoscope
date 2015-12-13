class RemoveFastaFromGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :fasta
  end
end
