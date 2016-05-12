require "rails_helper"

RSpec.describe QValues do
  describe "::create" do
    let(:l0) {
      [-2614.992001104497376, -2615.540162244748444,
       -2614.400605027360598, -2616.623661487894424,
       -2616.623661466769590]
    }
    let(:l1) {
      [-2614.055574634424374, -2611.251722133761177,
       -2607.267106581673033, -2616.635184732439029,
       -2616.623661482396528]
    }
    it "should respond" do
      expect(QValues).to respond_to(:create)
    end
    it "should return an array" do
      expect(QValues.create(l0: l0, l1: l1).to_a.class).to eq(Array)
    end
  end
end
