class FixProfileNames < ActiveRecord::Migration
  def change
    rename_table :run_profile_group_links, :profile_group_links
    rename_column :profile_group_links, :run_profile_id, :profile_id

    rename_table :run_profile_run_reports, :profile_reports
    rename_column :profile_reports, :run_profile_id, :profile_id

    rename_table :run_profile_tool_links, :profile_tool_links
    rename_column :profile_tool_links, :run_profile_id, :profile_id

    rename_table :run_profiles, :profiles

    rename_column :tool_run_reports, :run_profile_run_report_id, :profile_report_id
  end
end
