module Wrap::Fast
  class Output
    def initialize(spec, output)
      @out = spec.result_path
      @output = output
    end

    def report
      File.exist?(@out) &&
        result_file_content = File.open(@out).read
        
      OpenStruct.new(
        stdout: @output.stdout,
        stderr: @output.stderr,
        output: result_file_content
      )
    end
  end
end
