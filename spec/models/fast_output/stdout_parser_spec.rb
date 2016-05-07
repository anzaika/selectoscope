require "rails_helper"

RSpec.describe FastOutput::StdoutParser do
  let(:output) do
    File.open(
      File.join(
        Rails.root, "spec", "fixtures", "fast_output", "stdout.out")).read
  end
  def parser(text)
    FastOutput::StdoutParser.new(text)
  end

  describe "::new" do
    it "should work" do
      parser(output)
    end
  end

  describe "#parse_tree" do
    it "should respond" do
      expect(parser(output)).to respond_to(:parse_tree)
    end
    it "should return a PhylogeneticTree object" do
      expect(parser(output).parse_tree.class).to eq(PhylogeneticTree)
    end
    it "should return a PhylogeneticTree object with correct content" do
      expect(parser(output).parse_tree.newick.include?("(Vibrio_fischeri_ES114")).to be true
    end
  end
end
