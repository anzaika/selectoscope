class Profile < ActiveRecord::Base
  belongs_to :user

  has_many :profile_group_links, dependent: :destroy
  accepts_nested_attributes_for :profile_group_links
  has_many :groups, through: :profile_group_links

  has_many :profile_reports, dependent: :destroy

  has_one :tree, as: :treeable

  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :user_id, presence: true
  validates :tool_for_selection_id, presence: true

  # @param job [Symbol]
  # @return [Tool]
  def tool_for(job)
    id = self.send("tool_for_#{job}_id")
    id ? Tool.find(id) : nil
  end
end

# == Schema Information
#
# Table name: profiles
#
#  id                    :integer          not null, primary key
#  name                  :string(255)      not null
#  description           :text(65535)
#  user_id               :integer          not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  tool_for_alignment_id :integer
#  tool_for_filtering_id :integer
#  tool_for_tree_id      :integer
#  tool_for_selection_id :integer
#
# Indexes
#
#  index_profiles_on_user_id_and_name  (user_id,name)
#
