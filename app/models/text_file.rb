# == Schema Information
#
# Table name: text_files
#
#  id                :integer          not null, primary key
#  textifilable_type :string(20)       not null
#  textifilable_id   :integer          not null
#  meta              :string(255)
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_text_files_on_textifilable_id_and_textifilable_type  (textifilable_id,textifilable_type)
#

class TextFile < ActiveRecord::Base
  has_attached_file :file,
                    path: ":rails_root/storage/text_files/:id/:basename.:extension",
                    url:  "/text_file/:id/:filename"

  do_not_validate_attachment_file_type :file
  belongs_to :textifilable, polymorphic: true

  def web_view
    File.open(file.path).read.split("\n").join("</br>").html_safe
  end

  def raw
    File.open(file.path).read
  end
end
