module FastOutput
  class Branch
    THRESHOLD = BigDecimal.new("3.841459").freeze

    attr_reader :l0, :l1

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
      return nil unless l0 && l1
      (2 * (l0 - l1) - THRESHOLD) > 0
    end

    private

    def parse_l(ind)
      line = @text.scan(/LnL#{ind}\:\s+-?\d+.\d+/).first
      line.split(":").last if line
    end
  end
end
