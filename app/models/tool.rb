class Tool < ActiveRecord::Base
  has_many :profile_tool_links, dependent: :destroy
  has_many :tool_reports, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :class_name, uniqueness: true, presence: true
  validates :type, presence: true

  FOR_ALIGNMENT = "ToolForAlignment".freeze
  FOR_TREE = "ToolForTree".freeze
  FOR_SELECTION = "ToolForSelection".freeze

  scope :for_alignment, -> { where(type: FOR_ALIGNMENT) }
  scope :for_tree, -> { where(type: "ToolForTree") }
  scope :for_selection, -> { where(type: "ToolForSelection") }

  def self.types
    %w(ToolForAlignment ToolForTree ToolForSelection)
  end
end

# == Schema Information
#
# Table name: tools
#
#  id          :integer          not null, primary key
#  name        :string(150)      not null
#  description :text(65535)
#  class_name  :string(80)       not null
#  type        :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tools_on_type  (type)
#
