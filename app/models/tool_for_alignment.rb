class ToolForAlignment < Tool
  def self.result_for(tool_run_report)
    return nil unless tool_run_report.successful
    Bio::FastaFormat.new(
      tool_run_report.raw_file_content("output_alignment")
    )
  end

  # @param fasta [Bio::Alignment]
  # @return Bio::Alignment
  def execute(fasta)
    tool_run_report = Guidance.run(fasta, id)
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
