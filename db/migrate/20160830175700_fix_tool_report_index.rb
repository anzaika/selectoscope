class FixToolReportIndex < ActiveRecord::Migration
  def change
    remove_index :tool_reports, name: "index_tool_reports_on_profile_report_id_and_tool_id"
    add_index :tool_reports, :profile_report_id
  end
end
