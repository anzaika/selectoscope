# == Schema Information
#
# Table name: fast_results
#
#  id           :integer          not null, primary key
#  group_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  has_positive :boolean
#

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
