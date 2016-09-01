class ProfileReport < ActiveRecord::Base
  belongs_to :group
  belongs_to :profile

  has_many :tools, through: :profile

  delegate :tool_for_alignment, to: :profile
  delegate :tool_for_tree, to: :profile
  delegate :tool_for_selection, to: :profile

  has_many :tool_reports, dependent: :nullify

  has_one :alignment, as: :alignable, dependent: :destroy
  has_one :tree, as: :treeable, dependent: :destroy
  has_one :codeml_result, dependent: :destroy
  has_one :fast_result, dependent: :destroy

  def execute_pipeline
    PipelineJob.perform_async(id)
  end

  def execute_tool_for_alignment
    tool_for_alignment.execute(id)
  end

  def execute_tool_for_tree
    tool_for_tree.execute(id)
  end

  def execute_tool_for_selection
    tool_for_selection.execute(id)
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
