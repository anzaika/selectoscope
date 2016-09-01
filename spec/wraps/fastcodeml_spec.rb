require "rails_helper"

RSpec.describe Fastcodeml do
  describe "::run" do
    it "runs" do
      alignment = Fabricate(:alignment)
      tree = Fabricate(:tree)
      profile = Fabricate(:profile)
      profile_report = Fabricate(:profile_report, profile: profile, alignment: alignment, tree: tree)
    #   Fastcodeml.run(profile_report.id)
    end
  end
end
