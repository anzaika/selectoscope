class Alignment < ActiveRecord::Base
  belongs_to :group
  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy

  has_many :runnable_run_report_associations, as: :runnable, dependent: :destroy
  has_many :run_reports, through: :runnable_run_report_associations

  default_scope -> { order("created_at DESC") }
  scope :original, -> { where(meta: "original") }
  scope :processed, -> { where(meta: "processed") }

  # before_save :set_alignment_params

  def fasta
    File.open(fasta_file.file.path).read
  end

  def alignment
    Bio::Alignment::MultiFastaFormat.new(fasta).alignment
  end

  def molphy
    alignment.output_molphy(width: 100_000)
  end

  def phylip
    alignment.output_phylip
  end

  def self.dump
    Alignment.all.each(&:destroy)
  end

  def to_hash
    alignment.alignment_collect {|seq| seq }
  end

  private

  def set_alignment_params
    al = alignment
    self.length = al.alignment_length
  end
end
