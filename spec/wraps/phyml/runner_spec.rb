require "rails_helper"

RSpec.describe Phyml::Runner do
  let(:v) { Vault.new }
  let(:report) { ToolReport.new }

  describe "execute" do
    it "works" do
      r = Phyml::Runner.new({vault: v, report: report})
      r.execute
      expect(File.open(v.path_to_stdout).read).not_to be_empty
    end

    context "given a correctly initialized vault" do
      it "doesn't produce errors" do
        v.write_to_file(Helpers.fixed_fasta, Phyml::INPUT)
        r = Phyml::Runner.new({vault: v, report: report})
        r.execute
        expect(File.open(v.path_to_stderr).read).to be_empty
      end

      it "creates an output file" do
        v.write_to_file(Helpers.fixed_fasta, Phyml::INPUT)
        r = Phyml::Runner.new({vault: v, report: report})
        r.execute
        expect(FileTest.exist?(v.path_to(Phyml::OUTPUT))).to be true
      end
    end
  end
end
