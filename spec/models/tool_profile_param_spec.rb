require "rails_helper"

RSpec.describe ToolProfileParam, type: :model do
  let(:tool_profile_param) {Fabricate(:tool_profile_param)}

  describe "::create" do
    it "should be valid with valid params" do
      expect(tool_profile_param).to be_valid
    end
    it "should be invalid with wrong key" do
      p  = Fabricate.build(:tool_profile_param, key: 'v')
      expect(p.save).to be false
    end
  end

  describe "to_s" do
    it "should return a String" do
      p = tool_profile_param
      expect(p.to_s.class).to be String
    end
    context "for key '-v' and value '2'" do
      it "should return '-v 2'" do
        p = Fabricate(:tool_profile_param, key: '-v', value: '2')
        expect(p.to_s).to eq('-v 2')
      end
    end
  end
end
