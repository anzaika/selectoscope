require 'bio'
require 'faker'

module Helpers
  def self.dna_string
    counts = {'a'=>3,'c'=>3,'g'=>3,'t'=>3}
    "atg" + Bio::Sequence::NA.randomize(counts)
  end

  def self.fasta
    4.times.map{|i| ">#{i}\n#{self.dna_string}" }.join("\n")
  end

  def self.fixed_fasta
    4.times.map{|i| ">#{i}\natgatttta" }.join("\n")
  end

  def self.phylip_string
     Bio::Alignment::MultiFastaFormat
      .new(self.fasta).alignment.output_phylip
  end
end
