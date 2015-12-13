class AddGroupIdToTree < ActiveRecord::Migration
  def change
    add_column :trees, :group_id, :integer
  end
end
