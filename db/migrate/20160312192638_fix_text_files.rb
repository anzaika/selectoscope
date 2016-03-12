class FixTextFiles < ActiveRecord::Migration
  def change
    rename_column :text_files, :has_files_type, :textifilable_type
    rename_column :text_files, :has_files_id, :textifilable_id
    rename_column :text_files, :type, :meta
  end
end
