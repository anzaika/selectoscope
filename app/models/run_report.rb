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

class RunReport < ActiveRecord::Base
  belongs_to :group
  has_many :text_files, as: :textifilable, dependent: :destroy

  scope :alignment, -> { where(program: Wrap::Phyml::Run::PROGRAM) }
  scope :processed_alignment, -> { where(program: Wrap::Gblocks::Run::PROGRAM) }
  scope :tree, -> { where(program: Wrap::Phyml::Run::PROGRAM) }
  scope :codeml, -> { where(program: Wrap::Codeml::Run::PROGRAM) }
  scope :fast, -> { where(program: Wrap::Fast::Run::PROGRAM) }

  def stdout
    f = text_files.where(meta: 'stdout').first
    f ? File.open(f.file.path).read.split("\n").join("</br>").html_safe : nil
  end

  def stderr
    f = text_files.where(meta: 'stderr').first
    f ? File.open(f.file.path).read.split("\n").join("</br>").html_safe : nil
  end
end
