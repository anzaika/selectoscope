require 'bio'
require 'faker'

module Helpers
  def self.dna
    counts = {'a'=>3,'c'=>3,'g'=>3,'t'=>3}
    "atg" + Bio::Sequence::NA.randomize(counts)
  end

  def self.fasta(count = 4)
    count.times.map{|i| ">#{i}\n#{self.dna}" }.join("\n")
  end

  def self.fixed_fasta
    4.times.map{|i| ">#{i}\natgatttta" }.join("\n")
  end

  def self.phylip(seq_count=4)
     Bio::Alignment::MultiFastaFormat
      .new(self.fasta(seq_count)).alignment.output_phylip
  end

  def self.molphy(seq_count=4)
     Bio::Alignment::MultiFastaFormat
      .new(self.fasta(seq_count)).alignment.output_molphy
  end

  def self.newick(seq_count=4)
    "((1,2),3),4;"
  end
end
