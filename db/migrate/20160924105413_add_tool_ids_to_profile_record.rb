class AddToolIdsToProfileRecord < ActiveRecord::Migration
  def change
    add_column :profiles, :tool_for_alignment_id, :integer
    add_column :profiles, :tool_for_filtering_id, :integer
    add_column :profiles, :tool_for_tree_id, :integer
    add_column :profiles, :tool_for_selection_id, :integer
    drop_table :profile_tool_links
  end
end
