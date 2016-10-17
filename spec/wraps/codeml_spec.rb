require "rails_helper"

RSpec.describe Codeml do
  describe "execute" do
    it "returns an OpenStruct" do
      out = Codeml.new.execute({input: {alignment: Helpers.fasta, tree: Helpers.newick}})
      puts '*'*20
      puts out.report.stderr

      puts '*'*20
      expect(out.successful).to be true
      # expect(out.output.class).to eq(String)
    end
  end
end
