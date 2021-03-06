require "rails_helper"

RSpec.describe ToolReport, type: :model do
  describe "::create" do
    it "should be valid with valid params" do
      Fabricate(:tool_run_report)
    end
  end

  describe "decode_all_text_files" do
    it "shou decode all files" do
      profile = Fabricate(:profile_report)
      report = Fabricate(:tool_run_report, profile_report: profile)
      ident = profile.group.identifiers.first
      codename = ident.codename
      name = ident.name
      textfile = Fabricate(:text_file, textifilable: report, content: codename)
      report.decode_all_text_files
      expect(textfile.raw.include?(name)).to be true
    end
  end
end
