class Group < ActiveRecord::Base
  has_one :fasta_file, as: :representable_as_fasta, dependent: :destroy
  has_many :profile_group_links, dependent: :destroy
  has_many :profiles, through: :profile_group_links
  has_many :profile_reports, dependent: :destroy

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

  def execute_pipeline_with_profile(profile_id)
    report = profile_reports.find_by_profile_id(profile_id)
    report.destroy if report
    ProfileReport.create(profile_id: profile_id, group_id: id).execute_pipeline
  end

  def execute_pipeline_for_all_profiles
    profiles.pluck(:id).each{|pr_id| execute_pipeline_with_profile(pr_id) }
  end

  def enigma
    Identifier::Enigma.new(id)
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
