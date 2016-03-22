class Alignment < ActiveRecord::Base
  belongs_to :group
  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy

  has_many :runnable_run_report_associations, as: :runnable, dependent: :destroy
  has_many :run_reports, through: :runnable_run_report_associations

  scope :original, -> { where(meta: "original") }
  scope :processed, -> { where(meta: "processed") }

  def to_fasta_string
    File.open(fasta_file.file.path).read
  end

  def to_bioruby_alignment_object
    Bio::Alignment::MultiFastaFormat.new(to_fasta_string)
  end

  def to_molphy_string
    to_bioruby_alignment_object
      .alignment
      .output_molphy(width: 100_000)
  end

  def phylip
    alignment.output_phylip
  end

  def to_hash
    to_bioruby_alignment_object.alignment.to_hash
    # alignment.alignment_collect {|seq| seq }
  end
end
