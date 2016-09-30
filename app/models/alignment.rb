class Alignment < ActiveRecord::Base
  belongs_to :alignable, polymorphic: true
  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy

  delegate :to_fasta_string, to: :fasta_file
  delegate :to_bioruby_alignment_object, to: :fasta_file
  delegate :to_hash, to: :fasta_file

  def to_molphy_string
    fasta_file.to_molphy_text_format
  end
end

# == Schema Information
#
# Table name: alignments
#
#  id             :integer          not null, primary key
#  alignable_id   :integer
#  meta           :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  alignable_type :string(50)
#
# Indexes
#
#  index_alignments_on_alignable_id_and_alignable_type  (alignable_id,alignable_type)
#
