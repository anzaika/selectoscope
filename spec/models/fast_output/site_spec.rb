require "rails_helper"

RSpec.describe FastOutput::Site do
  describe "::new" do
    it "should work" do
      site(VALID_SITE_TEXT)
    end
  end
  describe "#branch" do
    it "should work" do
      expect(site(VALID_SITE_TEXT)).to respond_to(:branch)
    end
    it "should return a Fixnum" do
      expect(site(VALID_SITE_TEXT).branch.class).to be(Fixnum)
    end
    it "should return a correct value" do
      expect(site(VALID_SITE_TEXT).branch).to eq(1)
    end
  end
  describe "#position" do
    it "should work" do
      expect(site(VALID_SITE_TEXT)).to respond_to(:position)
    end
    it "should return a Fixnum" do
      expect(site(VALID_SITE_TEXT).position.class).to be(Fixnum)
    end
    it "should return a correct value" do
      expect(site(VALID_SITE_TEXT).position).to eq(171)
    end
  end
  describe "#probability" do
    it "should work" do
      expect(site(VALID_SITE_TEXT)).to respond_to(:probability)
    end
    it "should return a BigDecimal" do
      expect(site(VALID_SITE_TEXT).probability.class).to be(BigDecimal)
    end
    it "should return a correct value" do
      expect(site(VALID_SITE_TEXT).probability).to eq(BigDecimal.new("0.991661"))
    end
  end

  VALID_SITE_TEXT =
    "PositiveSelectionSite for branch:    1  Site:    171  Prob:  0.991661".freeze
  def site(text)
    FastOutput::Site.new(text)
  end
end
