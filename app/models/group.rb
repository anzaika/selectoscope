class Group < ActiveRecord::Base
  has_many :sequences, dependent: :destroy
  has_many :identifiers, through: :sequences
  has_many :alignments, dependent: :destroy
  has_one :codeml_result, dependent: :destroy
  has_one :fast_result, dependent: :destroy
  has_one :tree, dependent: :destroy
  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy
  validates_associated :fasta_file
  accepts_nested_attributes_for :fasta_file, allow_destroy: true
  belongs_to :batch, counter_cache: "groups_count"
  belongs_to :user

  default_scope -> { includes(:tree, :codeml_result, :fast_result)}
  scope :without_alignment,
        -> { includes(:alignments).where(alignments: {group_id: nil}) }
  scope :with_tree, -> { joins(:tree) }
  scope :with_codeml, -> { joins(:codeml_result) }
  scope :with_fast, -> { joins(:fast_result) }
  scope :with_positive, -> { joins(:fast_result).where(fast_results: {has_positive: true}) }
  scope :without_positive, -> { joins(:fast_result).where(fast_results: {has_positive: false}) }

  validates_presence_of :fasta_file

  after_create :parse_fasta_file_for_processing, :set_has_paralogs

  def name
    "Group " + id.to_s
  end

  def molphy
    sequences.output_molphy(width: 100_000)
  end

  def to_fasta(codenames: true)
    to_bio_alignment_object(codenames: codenames)
      .output_fasta(width: 100_000)
  end

  def identifier_list
    identifiers.map(&:name)
  end

  def to_bio_alignment_object(codenames: true)
    if codenames
      Bio::Alignment::OriginalAlignment.new(sequences.map(&:seq_with_codename))
    else
      Bio::Alignment::OriginalAlignment.new(sequences.map(&:seq_with_name))
    end
  end

  def set_avg_sequence_length
    update_attribute(:avg_sequence_length, avg_sequence_length.to_i)
  end

  def avg_sequence_length
    lengths = sequences.map {|g| g.sequence.length }
    (lengths.inject(0.0) {|s, e| s + e }) / lengths.size
  end

  def set_has_paralogs
    names = identifiers.map(&:name)
    value = names.size != names.uniq.size
    update_attribute(:has_paralogs, value)
  end

  def parse_fasta_file_for_processing
    fasta_file.each_seq_with_description do |desc, seq|
      org = Identifier.find_or_create_by(name: desc)
      Sequence.create(sequence: seq, identifier: org, group: self)
    end
  end
end
