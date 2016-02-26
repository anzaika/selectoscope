class CodemlResult < ActiveRecord::Base
  belongs_to :group
  has_many :text_files, as: :has_text_files
end
