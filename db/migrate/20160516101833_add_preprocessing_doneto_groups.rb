class AddPreprocessingDonetoGroups < ActiveRecord::Migration
  def change
    add_column :groups, :preprocessing_done, :boolean, default: false, null: false
  end
end
