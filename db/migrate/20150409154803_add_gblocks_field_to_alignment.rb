class AddGblocksFieldToAlignment < ActiveRecord::Migration
  def change
    add_column :alignments, :gblocks, :boolean
  end
end
