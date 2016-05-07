module FastOutput
  class OutputParser
    BRANCH_REGULAR =
      /Branch\:\s+\d+/
    SITE_REGULAR =
      /PositiveSelectionSite for branch\:\s+\d+\s+Site\:\s+\d+\s+Prob\:\s+\d+.\d+/
    def initialize(text)
      @text = text
    end

    def parse_branches
      @text.split(BRANCH_REGULAR)
           .tap(&:shift)
           .map {|text| FastOutput::Branch.new(text) }
    end

    def parse_sites
      @text.scan(SITE_REGULAR)
           .map{|text| FastOutput::Site.new(text) }
    end

  end
end
