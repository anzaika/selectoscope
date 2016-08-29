class CreateRunProfileToolLinks < ActiveRecord::Migration
  def change
    create_table :profile_tool_links do |t|
      t.integer :profile_id, null: false
      t.integer :tool_id, null: false
    end
    add_index :profile_tool_links, %i(tool_id profile_id), unique: true
    add_index :profile_tool_links, :profile_id
  end
end
