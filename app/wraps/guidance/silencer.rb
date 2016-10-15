require "bio"

class Guidance
  # This is an action class that replaces the positions with low scow (< THRESHOLD)
  # with N letters.
  class Silencer

    def initialize(args)
      @vault = args.fetch(:vault)
    end

    def execute
      read_alignment
      read_scores
      @bad_positions.each {|pos| @alignment.replace_slice("N", pos) }
      @alignment.output_fasta
    end

    def read_alignment
      @alignment =
        Bio::Alignment::MultiFastaFormat.new(
          File.open(
            @vault.path_to(Guidance::ALIGNMENT)
          ).read
        ).alignment
    end

    def read_scores
      @bad_positions =
        File.open(@vault.path_to(Guidance::SCORES))
            .readlines[1..-2]
            .map(&:split)
            .map    {|pos, score| [pos.to_i - 1, score.to_f] }
            .select {|_pos, score| score < Guidance::THRESHOLD }
            .map    {|pos, _score| pos }
    end
  end
end
