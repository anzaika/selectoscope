class FastResult < ActiveRecord::Base
  belongs_to :group
  has_one :text_file, as: :textifilable, dependent: :destroy

  def output
    File.open(text_file.file.path).read
  end

  def process_output
    FastResult::ProcessOutput.new(self.id).process
  end
end
