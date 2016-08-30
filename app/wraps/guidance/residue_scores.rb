module Guidance
  class ResidueScores
    THRESHOLD = 0.86

    def initialize(run)
      @scores_path =
        File.join(run.path_to_output, Guidance::Report::SCORES_FILENAME)
    end

    def bad_positions
      File.open(@scores_path)
          .readlines[1..-2]
        .map(&:split)
        .map    {|pos, score| [pos.to_i - 1, score.to_f] }
        .select {|_pos, score| score < THRESHOLD }
        .map    {|pos, _score| pos }
    end
  end
end
