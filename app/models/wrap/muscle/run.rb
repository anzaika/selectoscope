require 'open3'

module Wrap::Muscle
  class Run
    EXEC = 'muscle'
    VERSION = '3.8.31'

    def initialize(spec)
      @spec = spec
    end

    def run
      @spec.create_files
      out = execute
      Output.new(@spec).process
    ensure
      create_run_report(@spec, out)
    end

    private

    def execute
      Open3.popen3("#{EXEC} #{@spec.arguments}") do |_i, o, e, _t|
        OpenStruct.new(o: o.read, e: e.read)
      end
    end

    def create_run_report(spec, out)
      RunReport.create(
        stdout: out && out.o,
        stderr: out && out.e,
        directory_snapshot: Dir[spec.dir],
        program: EXEC,
        version: VERSION,
        params: spec.arguments
      )
    end

  end
end
