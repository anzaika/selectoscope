module FastOutput
  class Output
    def initialize(run_report_id)
      @report = RunReport.find(run_report_id)
      read_logs
    end

    def read_logs
      @output_raw = @report.text_files.find_by(meta: "output").raw
      @stdout_raw = @report.text_files.find_by(meta: "stdout").raw
    end

    # @return [Array<FastOutput::Branch>]
    def branches
      @branches ||=
        FastOutput::SetBranchQvalues
          .new(output_parser.parse_branches)
    end

    # @return [Array<FastOutput::Site>]
    def sites
      @sites ||= output_parser.parse_sites
    end

    # @return [PhylogeneticTree]
    def tree
      @tree ||= stdout_parser.parse_tree
    end

    # @return [PhylogeneticTree]
    def tree_with_positive
      @tree_positive ||= create_tree_with_positive
    end

    private

    def output_parser
      @output_parser ||= FastOutput::OutputParser.new(@output_raw)
    end

    def stdout_parser
      @stdout_parser ||= FastOutput::StdoutParser.new(@stdout_raw)
    end

    def create_tree_with_positive
      FastOutput::CreateTreeWithPositive.new(tree, branches).run
    end
  end
end
