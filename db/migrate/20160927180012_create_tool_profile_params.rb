class CreateToolProfileParams < ActiveRecord::Migration
  def change
    create_table :tool_profile_params do |t|
      t.string :key, null: false
      t.string :value, null: false
      t.integer :tool_profile_id, null: false

      t.timestamps null: false
    end

    add_index :tool_profile_params, :tool_profile_id
  end
end
