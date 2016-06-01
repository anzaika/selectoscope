require "rails_helper"

RSpec.describe ToolRunReport, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      Fabricate(:tool_run_report)
    end
  end
end
