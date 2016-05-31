class RunProfile < ActiveRecord::Base
  has_many :run_profile_group_links, dependent: :destroy
  has_many :groups, through: :run_profile_group_links
  has_many :run_profile_tool_links, dependent: :destroy
  has_many :tools, through: :run_profile_tool_links
  belongs_to :user

  validates :name, uniqueness: {scope: :user_id}
  validates :user_id, presence: true

  def tool_for_alignment
    tools.tool_for_alignment.limit(1).first
  end

  def tool_for_tree
    tools.tool_for_tree.limit(1).first
  end

  def tool_for_selection
    tools.tool_for_tree.limit(1).first
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
