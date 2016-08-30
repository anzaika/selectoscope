class ProfileReport < ActiveRecord::Base
  belongs_to :group
  belongs_to :profile

  has_many :tools, through: :profile

  delegate :tool_for_alignment, to: :profile
  delegate :tool_for_tree, to: :profile
  delegate :tool_for_selection, to: :profile

  has_many :tool_run_reports, dependent: :nullify

  has_one :alignment, as: :alignable, dependent: :destroy
  has_one :tree, as: :treeable, dependent: :destroy
  # has_one :codeml_result, dependent: :destroy
  # has_one :fast_result, dependent: :destroy

  def run_pipeline
    PipelineJob.perform_async(id)
  end
end

# == Schema Information
#
# Table name: profile_reports
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  profile_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
