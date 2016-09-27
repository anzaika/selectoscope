class CreateToolProfiles < ActiveRecord::Migration
  def change
    create_table :tool_profiles do |t|
      t.string :name, null: false
      t.text :description
      t.integer :tool_id, null: false

      t.timestamps null: false
    end

    add_index :tool_profiles, :tool_id
  end
end
