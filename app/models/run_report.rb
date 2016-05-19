class RunReport < ActiveRecord::Base
  belongs_to :group
  has_many :text_files, as: :textifilable, dependent: :destroy

  scope :alignment, -> { where(program: Phyml::Run::PROGRAM) }
  scope :processed_alignment, -> { where(program: Gblocks::Run::PROGRAM) }
  scope :tree, -> { where(program: Phyml::Run::PROGRAM) }
  scope :codeml, -> { where(program: Codeml::Run::PROGRAM) }
  scope :fast, -> { where(program: Fast::Run::PROGRAM) }

  def stdout
    read_file("stdout")
  end

  def stderr
    read_file("stderr")
  end

  def method_missing(name)
    raise "Unknown method: #{name}" unless name =~ /read_\w+/
    read_file(name.to_s.split("_").last)
  end

  private

  def read_file(name)
    f = text_files.where(meta: name).first
    f ? File.open(f.file.path).read.split("\n").join("</br>").html_safe : nil
  end
end

# == Schema Information
#
# Table name: run_reports
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
#  group_id           :integer
#  exec               :string(255)
#
# Indexes
#
#  index_run_reports_on_group_id  (group_id)
#
