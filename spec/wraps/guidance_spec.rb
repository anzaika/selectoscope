require "rails_helper"

RSpec.describe Guidance do
  describe "execute" do
    it "returns a string" do
      fasta = Helpers.fasta
      out = Guidance.new.execute({input: fasta})
      expect(out.class).to eq(String)
    end
    it "returns a path to resulting alignment" do
      fasta = Helpers.fasta
      out = Guidance.new.execute({input: fasta})
      expect(FileTest.exist?(out)).to eq(true)
    end
  end
end
