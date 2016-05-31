class CreateRunProfiles < ActiveRecord::Migration
  def change
    create_table :run_profiles do |t|
      t.integer :run_profile_link_id

      t.string :name, null: false
      t.text :description

      t.integer :user_id, null: false

      t.string :alignment, null: false, limit: 50
      t.string :tree, null: false, limit: 50
      t.string :selection, null: false, limit: 50

      t.timestamps null: false
    end

    add_index :run_profiles, %i(user_id run_profile_link_id)
    add_index :run_profiles, %i(user_id name)
  end
end
