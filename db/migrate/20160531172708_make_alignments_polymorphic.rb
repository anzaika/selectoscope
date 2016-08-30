class MakeAlignmentsPolymorphic < ActiveRecord::Migration
  def change
    remove_index :alignments, name:  :index_alignments_on_group_id
    rename_column :alignments, :group_id, :alignable_id
    add_column :alignments, :alignable_type, :string, limit: 50
    add_index :alignments, %i(alignable_id alignable_type)
  end
end
