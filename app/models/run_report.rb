class RunReport < ActiveRecord::Base
  belongs_to :group
  has_many :text_files, as: :textifilable, dependent: :destroy

  def stdout
    f = text_files.where(meta: 'stdout').first
    f ? File.open(f.file.path).read.split("\n").join("</br>").html_safe : nil
  end

  def stderr
    f = text_files.where(meta: 'stderr').first
    f ? File.open(f.file.path).read.split("\n").join("</br>").html_safe : nil
  end
end
