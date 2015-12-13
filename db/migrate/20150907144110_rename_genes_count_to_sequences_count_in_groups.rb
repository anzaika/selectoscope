class RenameGenesCountToSequencesCountInGroups < ActiveRecord::Migration
  def change
    rename_column :groups, :genes_count, :sequences_count
    remove_column :groups, :lopatina_id
  end
end
