require "rails_helper"

RSpec.describe Fastcodeml do
  describe "execute" do
    it "returns an OpenStruct" do
      out = Fastcodeml.new.execute({input: {alignment: Helpers.molphy , tree: Helpers.newick}})
      puts '*'*20
      puts out.report.stdout
      puts '*'*20
      expect(out.successful).to be true
      # expect(out.output.class).to eq(String)
    end
  end
end
