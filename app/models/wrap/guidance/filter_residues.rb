require 'bio'

module Wrap
class Guidance::FilterResidues

  def initialize(run)
    @alignment_path =
      File.join(run.path_to_output, Guidance::Report::ALIGNMENT_FILENAME)
    @bad_positions = Guidance::ResidueScores.new(run).bad_positions
  end

  def alignment
    @alignment ||=
      Bio::Alignment::MultiFastaFormat.new(File.open(@alignment_path).read).alignment
  end

  def run
    @bad_positions.each { |pos| @alignment.replace_slice("n", pos) }
    self
  end

end
end
