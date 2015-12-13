require 'open3'

module Wrap::Phyml
  class Run
    EXEC = 'phyml'

    def initialize(spec)
      @spec = spec
    end

    def run
      @spec.create_files
      execute
      Output.new(@spec).parse
      # ensure
      #   @spec.unlink
    end

    private

    def execute
      command = "dir=`mktemp -d` && cd $dir && #{EXEC} #{@spec.arguments}"
      Open3.popen3(command) do |_i, o, e, _t|
        Rails.logger.debug("Phyml execution stdout:\n" + o.read)
        Rails.logger.debug("Phyml execution stderr:\n" + e.read)
      end
    end
  end
end
