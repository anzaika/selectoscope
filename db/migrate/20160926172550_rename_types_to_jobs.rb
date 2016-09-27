class RenameTypesToJobs < ActiveRecord::Migration
  def change
    rename_column :tools, :type, :job
  end
end
