class Group < ActiveRecord::Base
  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy
  has_many :run_profile_group_links, dependent: :destroy
  has_many :run_profiles, through: :run_profile_group_links
  has_many :run_profile_run_reports, dependent: :destroy

  has_many :group_identifier_links, dependent: :destroy
  has_many :identifiers, through: :group_identifier_links

  validates_associated :fasta_file
  accepts_nested_attributes_for :fasta_file, allow_destroy: true

  belongs_to :batch, counter_cache: "groups_count"
  belongs_to :user

  validates :fasta_file, presence: true

  after_create :submit_process_job

  def name
    "Group " + id.to_s
  end

  def process_identifiers
    transform_identifiers_in_fasta_file
    save_identifiers
    update_attribute(:preprocessing_done, true)
  end

  def clear_pipeline_results
    run_reports.each(&:destroy)
    alignments.each(&:destroy)
    tree.destroy if tree
    codeml_result.destroy if codeml_result
    fast_result.destroy if fast_result
  end

  def submit_process_job
    Group::ProcessIdentifiersJob.perform_in(1.second, id)
  end

  def save_identifiers
    fasta_file.each_seq_with_description do |desc, _seq|
      begin
        identifier = Identifier.find_or_create_by(name: desc)
        identifiers << identifier
      rescue ActiveRecord::RecordNotUnique
        retry
      end
    end
  end

  def transform_identifiers_in_fasta_file
    TransformIdentifiers.new(id).transform
  end
end

# == Schema Information
#
# Table name: groups
#
#  id                  :integer          not null, primary key
#  avg_sequence_length :integer
#  batch_id            :integer
#  user_id             :integer
#  preprocessing_done  :boolean          default(FALSE), not null
#
# Indexes
#
#  index_groups_on_batch_id  (batch_id)
#  index_groups_on_user_id   (user_id)
#
