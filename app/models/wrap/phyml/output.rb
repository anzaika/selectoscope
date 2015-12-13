module Wrap::Phyml
  class Output
    def initialize(spec)
      @out = spec.result_path
    end

    def parse
      if File.exist?(@out)
        File.open(@out) { |f| f.read }.chomp
      else
        Rails.logger.error("Couldn't find phyml result file at: " + @out)
        nil
      end
    end
  end
end
