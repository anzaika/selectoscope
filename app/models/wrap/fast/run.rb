require 'open3'

# @author anzaika@gmail.com
module Wrap::Fast
  # @author anzaika@gmail.com
  class Run
    EXEC = 'fast'

    def initialize(spec)
      @spec = spec
    end

    def run
      @spec.create_files
      Output.new(@spec, execute).report
    ensure
      @spec.unlink
    end

    private

    def execute
      stdout = ''
      stderr = ''
      Open3.popen3("#{EXEC} #{@spec.arguments}") do |_, o, e, _|
        stdout = o.read
        stderr = e.read
        Rails.logger.info("Fast stdout:\n" + o.read)
        Rails.logger.info("Fast sterr:\n" + e.read)
      end
      OpenStruct.new(stdout: stdout, stderr: stderr)
    end
  end
end
