module FastOutput
  class Output
    def initialize(fast_result_id)
      @fs = FastResult.find(fast_result_id)
      read_logs
    end

    def read_logs
      @output_raw = File.open(@fs.output).read
      stdout_file = @fs.group.run_reports.fast.first.stdout
      @stdout_raw = File.open(stdout_file).read
    end

    # @return [Array<FastOutput::Branch>]
    def branches
      @branches ||= output_parser.parse_branches
    end

    # @return [Array<FastOutput::Site>]
    def sites
      @sites ||= output_parser.parse_sites
    end

    # @return [PhylogeneticTree]
    def tree
      @tree ||= stdout_parser.parse_tree
    end

    def tree_with_positive_info
      @tree_positive ||= create_tree_with_positive_report
    end

    private

    def output_parser
      @output_parser ||= FastOutput::OutputParser.new(@output_raw)
    end

    def stdout_parser
      @stdout_parser ||= FastOutput::StdoutParser.new(@stdout_raw)
    end

    def create_tree_with_positive_report
      FastOutput::CreateTreeWithPositiveInfo
        .new(PhylogeneticTree.new(@fs.group.tree.newick), tree, branches)
    end
  end
end
