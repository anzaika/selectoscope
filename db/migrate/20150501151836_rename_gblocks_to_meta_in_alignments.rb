class RenameGblocksToMetaInAlignments < ActiveRecord::Migration
  def change
    rename_column :alignments, :gblocks, :meta
    change_column :alignments, :meta, :string
    Alignment.all.each{|a| a.update_attribute(:meta, 'gblocks') if a.meta == 'true'}
  end
end
