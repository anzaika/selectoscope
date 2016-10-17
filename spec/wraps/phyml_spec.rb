require "rails_helper"

RSpec.describe Phyml do
  describe "execute" do
    it "returns an OpenStruct with alignment" do
      out = Phyml.new.execute({input: {alignment: Helpers.phylip}})
      expect(out.successful).to be true
      expect(out.output.class).to eq(String)
    end
  end
end
