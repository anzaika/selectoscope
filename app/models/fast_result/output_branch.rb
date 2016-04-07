class FastResult::OutputBranch

  THRESHOLD = 3.841459

  def initialize(text)
    @text = text
  end

  def positive?
    return nil unless l_one && l_zero
    (2 * (l_one - l_zero) - THRESHOLD) > 0
  end

  private

  def l_one
    @l_one ||=
      string.each_line
        .to_a
        .map {|l| l_one_from_string(l) }
        .compact
        .first
  end

  def l_zero
    @l_zero ||=
      string.each_line
        .to_a
        .map {|l| l_zero_from_string(l) }
        .compact
        .first
  end

  def l_zero_from_string(string)
    return nil unless string =~ /LnL0\:\s+(\s|-)\d+.\d+/
    string.split(":").last.to_f
  end

  def l_one_from_string(string)
    return nil unless string =~ /LnL1\:\s+(\s|-)\d+.\d+/
    string.split(":").last.to_f
  end
end
