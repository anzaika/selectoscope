class AddSuccessfulToRunReport < ActiveRecord::Migration
  def change
    add_column :run_reports, :successful, :boolean
  end
end
