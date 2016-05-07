require "rails_helper"

RSpec.describe FastOutput::OutputParser do
  let(:output) do
    File.open(
      File.join(
        Rails.root, "spec", "fixtures", "fast_output", "output.out")).read
  end

  describe "::new" do
    it "should work" do
      parser(output)
    end
  end
  

  describe "#parse_branches" do
    it "should work" do
      expect(parser(output)).to respond_to(:parse_branches)
    end
    it "should return an array" do
      expect(parser(output).parse_branches.class).to eq(Array)
    end
    it "should return an array with correct number of branches" do
      expect(parser(output).parse_branches.count).to be(9)
    end
    it "should return an array of FastOutput::Parser objects" do
      expect(parser(output).parse_branches.all?{|b| b.class == FastOutput::Branch}).to be true
    end
    it "should split output into valid branches" do
      expect(parser(output).parse_branches.first.l1).to eq(BigDecimal("-2366.614359"))
    end
  end

  describe "#parse_sites" do
    it "should work" do
      expect(parser(output)).to respond_to(:parse_sites)
    end
    it "should return an array" do
      expect(parser(output).parse_sites.class).to eq(Array)
    end
    it "should return an array with correct number of sites" do
      expect(parser(output).parse_sites.count).to be(42)
    end
  end

  def parser(text)
    FastOutput::OutputParser.new(text)
  end
end
