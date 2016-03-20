class Group < ActiveRecord::Base

  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy
  has_and_belongs_to_many :identifiers

  has_many :alignments, dependent: :destroy
  has_one :tree, dependent: :destroy
  has_one :codeml_result, dependent: :destroy
  has_one :fast_result, dependent: :destroy

  has_many :runnable_run_report_associations, as: :runnable, dependent: :destroy
  has_many :run_reports, through: :runnable_run_report_associations

  validates_associated :fasta_file
  accepts_nested_attributes_for :fasta_file, allow_destroy: true

  belongs_to :batch, counter_cache: "groups_count"
  belongs_to :user

  default_scope -> { includes(:tree, :codeml_result, :fast_result)}
  scope :with_positive, -> { joins(:fast_result).where(fast_results: {has_positive: true}) }
  scope :without_positive, -> { joins(:fast_result).where(fast_results: {has_positive: false}) }

  validates_presence_of :fasta_file

  after_create :process_sequence_identifiers

  def name
    "Group " + id.to_s
  end

  def to_bio_alignment_object(codenames: true)
    if codenames
      Bio::Alignment::OriginalAlignment.new(sequences.map(&:seq_with_codename))
    else
      Bio::Alignment::OriginalAlignment.new(sequences.map(&:seq_with_name))
    end
  end

  private

  def process_sequence_identifiers
    fasta_file.each_seq_with_description do |desc, seq|
      identifier = Identifier.find_or_create_by(name: desc)
      self.identifiers << identifier
    end
  end
end
