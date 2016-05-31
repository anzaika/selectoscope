class CreateRunProfiles < ActiveRecord::Migration
  def change
    create_table :run_profiles do |t|
      t.string :name, null: false
      t.text :description
      t.integer :user_id, null: false
      t.timestamps null: false
    end

    add_index :run_profiles, %i(user_id name)
  end
end
