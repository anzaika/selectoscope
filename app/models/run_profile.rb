class RunProfile < ActiveRecord::Base
  has_many :run_profile_group_links, dependent: :destroy
  has_many :groups, through: :run_profile_group_links
  has_many :run_profile_tool_links, dependent: :destroy
  has_many :tools, through: :run_profile_tool_links
  belongs_to :user

  accepts_nested_attributes_for :run_profile_group_links
  accepts_nested_attributes_for :run_profile_tool_links

  attr_accessor :tool_for_alignment_id
  attr_accessor :tool_for_tree_id
  attr_accessor :tool_for_selection_id

  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true
  validates :tool_for_alignment_id, presence: true
  validates :tool_for_tree_id, presence: true
  validates :tool_for_selection_id, presence: true

  after_create :create_run_profile_tool_links

  def tool_for_alignment
    tools.for_alignment.limit(1).first
  end

  def tool_for_tree
    tools.for_tree.limit(1).first
  end

  def tool_for_selection
    tools.for_tree.limit(1).first
  end

  # @param group_id [Integer]
  def execute_for_group(group_id)
    RunProfileRunReport.create(group_id: group_id, run_profile_id: id).run_pipeline
  end

  private

  def create_run_profile_tool_links
    RunProfileToolLink.create(
      run_profile_id: id, tool_id: tool_for_alignment_id
    )
    RunProfileToolLink.create(
      run_profile_id: id, tool_id: tool_for_tree_id
    )
    RunProfileToolLink.create(
      run_profile_id: id, tool_id: tool_for_selection_id
    )
  end
end

# == Schema Information
#
# Table name: run_profiles
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text(65535)
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_run_profiles_on_user_id_and_name  (user_id,name)
#
