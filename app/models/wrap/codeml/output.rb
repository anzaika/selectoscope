module Wrap::Codeml
  class Output
    def initialize(spec, output)
      @out = spec.result_path
      @output = output
      parse
    end

    def report
      OpenStruct.new(
        k: @k,
        w0: @w0,
        w1: @w1,
        p0: @p0,
        p1: @p1,
        tree: @tree
        # stdout: @output.stdout,
        # stderr: @output.stderr,
        # output: File.open(@out).read
      )
    end

    private

    def parse
      File.open(@out) do |f|
        f.readlines.each { |l| process(l) }
      end
    end

    def process(l)
      if l =~ /^kappa \(ts\/tv\) =/
        @k = l.split('=').last.to_f
      elsif l =~ /^\(.+: ([0-9]*\.[0-9]+|[0-9]), \(.+:/
        @tree = l.chomp
      elsif l =~ /^p:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
        @p0 = l.split(' ')[1].to_f
        @p1 = l.split(' ')[2].to_f
      elsif l =~ /^w:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
        @w0 = l.split(' ')[1].to_f
        @w1 = l.split(' ')[2].to_f
      end
    end
  end
end
