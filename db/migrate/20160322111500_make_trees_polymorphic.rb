class MakeTreesPolymorphic < ActiveRecord::Migration
  def change
    drop_table :trees

    create_table :trees do |t|
      t.binary :newick
      t.integer :treeable_id, null: false
      t.string :treeable_type, null: false, limit: 20
    end

    add_index :trees, [:treeable_id, :treeable_type]
  end
end
