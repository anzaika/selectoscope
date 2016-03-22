class TextFile < ActiveRecord::Base
  has_attached_file :file,
                    path: ":rails_root/storage/text_files/:id/:basename.:extension",
                    url:  "/text_file/:id/:filename"

  do_not_validate_attachment_file_type :file
  belongs_to :textifilable, polymorphic: true
end
