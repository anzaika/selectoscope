class RenameRunToRunReport < ActiveRecord::Migration
  def change
    rename_table :runs, :run_reports
  end
end
