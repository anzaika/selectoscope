class CreateGenes < ActiveRecord::Migration
  def change
    create_table :genes do |t|
      t.text     :sequence
      t.integer  :organism_id
      t.integer  :group_id
    end

    add_index :genes, :group_id
    add_index :genes, [:organism_id, :group_id]
  end
end
