class RenameRunReportToToolRunReport < ActiveRecord::Migration
  def change
    rename_table :run_reports, :tool_run_reports
    remove_index :tool_run_reports, name: :index_tool_run_reports_on_group_id
    rename_column :tool_run_reports, :group_id, :profile_report_id
    add_column :tool_run_reports, :tool_id, :integer, null: false
    add_index :tool_run_reports, %i(profile_report_id tool_id), unique: true
    add_index :tool_run_reports, :tool_id
  end
end
