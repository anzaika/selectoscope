class CreateRunProfileToolLinks < ActiveRecord::Migration
  def change
    create_table :run_profile_tool_links do |t|
      t.integer :run_profile_id, null: false
      t.integer :tool_id, null: false
    end
    add_index :run_profile_tool_links, %i(tool_id run_profile_id), unique: true
    add_index :run_profile_tool_links, :run_profile_id
  end
end
