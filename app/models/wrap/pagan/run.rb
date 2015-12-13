require 'open3'

module Wrap::Pagan
  class Run
    EXEC = 'pagan'
    VERSION = '0.56'

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
        stdout: out.o,
        stderr: out.e,
        directory_snapshot: Dir[spec.dir],
        program: EXEC,
        version: VERSION,
        params: spec.arguments
      )
    end

  end
end
