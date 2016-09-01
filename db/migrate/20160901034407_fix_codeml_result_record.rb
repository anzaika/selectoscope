class FixCodemlResultRecord < ActiveRecord::Migration
  def change
    rename_column :codeml_results, :group_id, :profile_report_id
    rename_column :fast_results, :run_report_id, :profile_report_id
    change_column_null :fast_results, :profile_report_id, true
  end
end
