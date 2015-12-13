class ChangeOutputColumnsInFastResult < ActiveRecord::Migration
  def change
    add_column :fast_results, :stdout, :text
    add_column :fast_results, :stderr, :text
    rename_column :fast_results, :report, :output
  end
end
