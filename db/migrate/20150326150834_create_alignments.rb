class CreateAlignments < ActiveRecord::Migration
  def change
    create_table :alignments do |t|
      t.text :fasta
    end
  end
end
