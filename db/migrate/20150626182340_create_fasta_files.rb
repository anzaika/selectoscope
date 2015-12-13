class CreateFastaFiles < ActiveRecord::Migration
  def change
    create_table :fasta_files do |t|
      t.string :representable_as_fasta_type
      t.integer :representable_as_fasta_id

      t.timestamps null: false
    end
  end
end
