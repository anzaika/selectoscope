class AddFastaToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :fasta, :string
  end
end
