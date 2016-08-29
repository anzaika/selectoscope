require "rails_helper"

RSpec.describe ExecuteToolForAlignment do
  describe "new" do
    context "given that alignment tool finishes successfully" do
      it "adds alignment to RunProfileRunReport" do
        rprr = Fabricate(:profile_report)
        ExecuteToolForAlignment.new(rprr.id)
        expect(rprr.alignment.class == Alignment).to be true
      end
    end
  end
end
