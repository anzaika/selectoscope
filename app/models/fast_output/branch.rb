module FastOutput
  class Branch
    THRESHOLD = BigDecimal.new("3.841459").freeze

    attr_reader :l0, :l1
    attr_accessor :q

    def initialize(text)
      @text = text
    end

    def l0
      l = parse_l(0)
      @l0 ||= BigDecimal.new(l).round(6) if l
    end

    def l1
      l = parse_l(1)
      @l1 ||= BigDecimal.new(l).round(6) if l
    end

    def positive?
      @positive ||= compute_positive
    end

    def number
      @number ||=
        @text.scan(/Branch:\s+\d+/)
             .first
             .split(":")
             .last
             .to_i
    end

    private

    def compute_positive
      return nil unless l0 && l1
      (2 * (l0 - l1) - THRESHOLD) > 0
    end

    def parse_l(ind)
      line = @text.scan(/LnL#{ind}\:\s+-?\d+.\d+/).first
      line.split(":").last if line
    end
  end
end
