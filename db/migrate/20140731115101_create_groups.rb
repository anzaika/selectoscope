class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :genes_count
      t.integer :lopatina_id
    end

    add_index :groups, [:lopatina_id]
  end
end
