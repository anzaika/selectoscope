require "rails_helper"

RSpec.describe Guidance do
  describe "execute" do
    it "returns an OpenStruct with alignment" do
      fasta = Helpers.fixed_fasta
      out = Guidance.new.execute({input: fasta})
      expect(out.alignment.class).to eq(String)
    end
  end
end
