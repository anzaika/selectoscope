require "rails_helper"

RSpec.describe Guidance do
  describe "execute" do
    it "returns an OpenStruct with alignment" do
      out = Guidance.new.execute({input: Helpers.fixed_fasta})
      expect(out.alignment.class).to eq(String)
    end
  end
end
