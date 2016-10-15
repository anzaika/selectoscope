require "rails_helper"

RSpec.describe Phyml do
  describe "execute" do
    it "returns an OpenStruct with alignment" do
      phylip = Helpers.phylip_string
      out = Phyml.new.execute({input: phylip})
      expect(out.successful).to be true
      expect(out.tree.class).to eq(String)
    end
  end
end
