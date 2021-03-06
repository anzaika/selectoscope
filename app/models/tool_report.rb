class ToolReport < ActiveRecord::Base
  belongs_to :profile_report
  belongs_to :tool
  has_many :text_files, as: :textifilable, dependent: :destroy
  has_one :group, through: :profile_report

  scope :for_alignment, -> { joins(:tool).where("tools.type = ?", Tool::FOR_ALIGNMENT) }
  scope :for_tree, -> { joins(:tool).where("tools.type = ?", Tool::FOR_TREE) }
  scope :for_selection, -> { joins(:tool).where("tools.type = ?", Tool::FOR_SELECTION) }

  def decode_all_text_files
    enigma = Enigma.new(profile_report.group.id)
    text_files.each {|f| enigma.decode_file(f.file.path) }
  end

  def stdout
    read_file("stdout")
  end

  def stderr
    read_file("stderr")
  end

  # @param meta [String]
  # @return [TextFile]
  def get_file(meta)
    text_files.find_by_meta(meta)
  end

  # read_*
  # for example read_output_alignment
  # @return String
  def method_missing(name)
    raise "Unknown method: #{name}" unless name =~ /read_\w+/
    read_file(name.to_s.split("_").last)
  end

  def raw_file_content
    f = text_files.where(meta: name).first
    f ? File.open(f.file.path).read : nil
  end

  private

  def read_file(name)
    f = text_files.where(meta: name).first
    f ? File.open(f.file.path).read.split("\n").join("</br>").html_safe : nil
  end
end

# == Schema Information
#
# Table name: tool_reports
#
#  id                 :integer          not null, primary key
#  program            :string(20)
#  version            :string(255)
#  params             :string(255)
#  start              :date
#  finish             :date
#  runtime            :integer
#  directory_snapshot :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  successful         :boolean
#  profile_report_id  :integer
#  exec               :string(255)
#  tool_id            :integer          not null
#
# Indexes
#
#  index_tool_reports_on_profile_report_id  (profile_report_id)
#  index_tool_reports_on_tool_id            (tool_id)
#
