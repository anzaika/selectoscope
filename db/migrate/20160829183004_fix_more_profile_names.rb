class FixMoreProfileNames < ActiveRecord::Migration
  def change
    rename_table :tool_run_reports, :tool_reports
  end
end
