class RenameProfileRunReportToRunProfileRunReport < ActiveRecord::Migration
  def change
    rename_table :run_profile_reports, :run_profile_run_reports
  end
end
