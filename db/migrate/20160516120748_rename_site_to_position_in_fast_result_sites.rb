class RenameSiteToPositionInFastResultSites < ActiveRecord::Migration
  def change
    rename_column :fast_result_sites, :site, :position
  end
end
