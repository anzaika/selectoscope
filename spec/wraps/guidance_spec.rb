require "rails_helper"

RSpec.describe Guidance do
  describe "::run" do
    it "runs" do
      tool = Fabricate(:tool)
      result = Guidance.run(fasta_string, tool.id)
      expect(result.successful).to be true
    end
  end
end

def fasta_string
  # nucs = %w(A T G C)
  # counts = Array.new(4) { 3 * Faker::Number.number(1).to_i }
  # counts = Array.new(4) { 3 }
  seqs = Array.new(4) { Bio::Sequence::NA.new("atgttttga") }
  names = Array.new(4) { Faker::Lorem.word }
  Bio::Alignment.new(names.zip(seqs).to_h).output_fasta
end
