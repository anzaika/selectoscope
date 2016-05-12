class AddQToFastResultBranches < ActiveRecord::Migration
  def change
    add_column :fast_result_branches, :q, :decimal, precision: 16, scale: 11
  end
end
