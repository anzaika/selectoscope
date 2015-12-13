class TextFile < ActiveRecord::Base
  has_attached_file :file,
                    path: ":rails_root/public/text_file/:id/:filename",
                    url:  "/text_file/:id/:filename"

  validates_attachment :file,
                       content_type: {content_type: ["application/octet-stream", "text/plain"]}
end
