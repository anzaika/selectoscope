class CreateRunProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.text :description
      t.integer :user_id, null: false
      t.timestamps null: false
    end

    add_index :profiles, %i(user_id name)
  end
end
