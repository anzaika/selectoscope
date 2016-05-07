module FastOutput
  class Site
    attr_reader :branch, :position, :probability

    def initialize(text)
      @text = text
    end

    def branch
      @branch ||=
        @text.scan(/branch:\s+\d+/)
             .first
             .split(":")
             .last
             .to_i
    end

    def position
      @position ||=
        @text.scan(/Site:\s+\d+/)
             .first
             .split(":")
             .last
             .to_i
    end

    def probability
      @probability ||= set_probability
    end

    private

    def set_probability
      val =
        @text.scan(/Prob:\s+\d+.\d+/)
             .first
             .split(":")
             .last
      BigDecimal.new(val)
    end
  end
end
