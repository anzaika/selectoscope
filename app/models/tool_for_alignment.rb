class ToolForAlignment < Tool
  # @param fasta [Bio::Alignment]
  # @param rprr_id [Integer] id of RunProfileRunReport
  # @return Bio::Alignment
  def execute(rprr_id)
    ExecuteToolForAlignment.new(rprr_id)
  end
end

# == Schema Information
#
# Table name: tools
#
#  id          :integer          not null, primary key
#  name        :string(150)      not null
#  description :text(65535)
#  class_name  :string(80)       not null
#  type        :string(50)       not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_tools_on_type  (type)
#
