require "rails_helper"

RSpec.describe Guidance::Runner do
  let(:v) { Vault.new }

  describe "execute" do
    it "works" do
      r = Guidance::Runner.new({vault: v})
      r.execute
      expect(File.open(v.path_to_stdout).read).not_to be_empty
    end

    context "given a correctly initialized vault" do
      it "doesn't produce errors" do
        v.write_to_file(Helpers.fixed_fasta, Guidance::INPUT)
        r = Guidance::Runner.new({vault: v})
        r.execute
        expect(File.open(v.path_to_stderr).read).to be_empty
      end

      it "creates an output file" do
        v.write_to_file(Helpers.fixed_fasta, Guidance::INPUT)
        r = Guidance::Runner.new({vault: v})
        r.execute
        expect(FileTest.exist?(v.path_to(Guidance::RESULT))).to be true
      end
    end
  end
end
