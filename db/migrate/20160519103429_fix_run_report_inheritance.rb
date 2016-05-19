class FixRunReportInheritance < ActiveRecord::Migration
  def change
    remove_column :fast_results, :group_id
    add_column :fast_results, :run_report_id, :integer, null: false
    add_index :fast_results, :run_report_id
  end
end
