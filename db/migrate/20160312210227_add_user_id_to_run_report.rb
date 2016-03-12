class AddUserIdToRunReport < ActiveRecord::Migration
  def change
    add_column :run_reports, :user_id, :integer
  end
end
