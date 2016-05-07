require "rails_helper"

RSpec.describe FastOutput::Branch do
  describe "::new" do
    it "should work" do
      branch(GOOD_STRING)
    end
  end

  describe "#l0" do
    it "should return a correct value" do
      expect(branch(GOOD_STRING).l0).to eq(BigDecimal.new("-2368.564588"))
    end
    it "should return nil if LnL0: NA" do
      string = %(
        Branch:    1

          LnL0:  NA
      )
      expect(branch(string).l0).to be_nil
    end
  end

  describe "#l1" do
    it "should return a correct value" do
      expect(branch(GOOD_STRING).l1).to eq(BigDecimal.new("-2365.254919"))
    end
  end

  GOOD_STRING = %(
    Branch:    1

      LnL0:  -2368.564588054288379
    Branch lengths:  0.0478330  0.0436304  0.1804739  0.2625488  0.1084100  0.3576602  0.0000000  0.0000000
      0.0663866  0.3523075  0.0235713  0.1123723  0.0971856  0.0735985  0.0235758  0.0240293
      0.0000000 -0.0000000  3.0584212  0.2789787  0.1229262  0.0059833  0.0123708  0.0059584
      0.0061298  0.0000000  0.0000000  0.0000000  0.0000000  0.0000000  0.0000000  0.0000000
      0.0000000  0.0000000  0.0000000  0.0000000  0.0000000
    p0:  0.7816136  p1:  0.1842861  p2a:  0.0275942  p2b:  0.0065061
    w0:  0.0559300  k:   3.9610384

      LnL1:  -2365.254918761547287
    Branch lengths:  0.0492328  0.0422434  0.1863847  0.2605868  1.8156818  0.3602411  0.0000000  0.0000000
      0.0736420  0.3592597  0.0222150  0.1113638  0.0970231  0.0740595  0.0235947  0.0240412
      0.0000000  0.0000000  3.0383238  0.2785728  0.1248313  0.0059835  0.0123835  0.0059591
      0.0061351  0.0000000  0.0000000  0.0000000  0.0000000  0.0000000  0.0000000  0.0000000
      0.0000000  0.0000000  0.0000000  0.0000000  0.0000000
    p0:  0.7978718  p1:  0.1883030  p2a:  0.0111854  p2b:  0.0026398
    w0:  0.0561462  k:   4.0722535  w2: 999.0000000
  ).freeze

  def branch(string)
    FastOutput::Branch.new(string)
  end
end
