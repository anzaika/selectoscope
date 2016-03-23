class FixRunReportAssociations < ActiveRecord::Migration
  def change
    drop_table :runnable_run_report_associations
    rename_column :run_reports, :user_id, :group_id
    remove_column :run_reports, :jobid
    remove_column :run_reports, :runnable_id
    remove_column :run_reports, :result
    add_column :run_reports, :exec, :string

    remove_column :groups, :sequences_count
    remove_column :groups, :has_paralogs

    remove_column :fast_results, :output

    change_column :identifiers, :codename, :string, limit: 10

    change_column :run_reports, :program, :string, limit: 20

    change_column :text_files, :textifilable_type, :string, limit: 20
    change_column_null :text_files, :textifilable_type, false
    change_column_null :text_files, :textifilable_id, false

    remove_index :text_files, name: "index_text_files_on_has_files_type_and_type_and_has_files_id"
    remove_index :text_files, name: "index_text_files_on_textifilable_type_and_textifilable_id"
    add_index :text_files, [:textifilable_id, :textifilable_type]
  end
end
