class RenameProfileReportToProfileReport < ActiveRecord::Migration
  def change
    rename_table :profile_reports, :profile_reports
  end
end
