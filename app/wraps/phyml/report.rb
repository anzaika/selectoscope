module Phyml
  class Report < ReportBase

    def tool_id
      @profile_report.tool_for_tree.id
    end

    def save_tool_results
      newick = File.open(@run.path_to_output).read.chomp.squish
      newick_decoded = @profile_report.group.enigma.decode_string(newick)
      Tree.create(newick: newick_decoded, treeable: @profile_report)
    end
  end
end
