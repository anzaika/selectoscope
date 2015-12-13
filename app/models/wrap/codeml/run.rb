require "open3"

module Wrap::Codeml
  class Run
    EXEC = "cdmw.py"

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
      stdout = ""
      stderr = ""
      Open3.popen3("dir=`mktemp -d` && cd $dir && #{EXEC} #{@spec.arguments}") do |_i, o, e, _t|
        stdout = o.read
        stderr = e.read
        # Rails.logger.debug("Codeml execution stdout:\n"+o.read)
        # Rails.logger.debug("Codeml execution stderr:\n"+e.read)
      end
      OpenStruct.new(stdout: stdout, stderr: stderr)
    end
  end
end
