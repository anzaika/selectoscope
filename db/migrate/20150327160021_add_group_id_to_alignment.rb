class AddGroupIdToAlignment < ActiveRecord::Migration
  def change
    add_column :alignments, :group_id, :integer
  end
end
