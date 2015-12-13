class RenameOrganismToIdentifier < ActiveRecord::Migration
  def change
    rename_table :organisms, :identifiers
    rename_table :genes, :sequences
    rename_column :sequences, :organism_id, :identifier_id
    rename_column :identifiers, :genes_count, :sequences_count
  end
end
