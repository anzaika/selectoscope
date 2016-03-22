class RunReport < ActiveRecord::Base
  has_many :runnable_run_report_associations, dependent: :destroy
  has_many :text_files, as: :textifilable

  def stdout
    f = text_files.where(meta: 'stdout').first
    (f ? File.open(f.file.path).read : nil).split("\n").join("</br>").html_safe
  end

  def stderr
    f = text_files.where(meta: 'stderr').first
    f ? File.open(f.file.path).read : nil
  end
end
