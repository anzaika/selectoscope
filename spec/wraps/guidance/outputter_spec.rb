require "rails_helper"

RSpec.describe Guidance::Outputter do
  describe "execute" do
    let(:v) { Vault.new }
    let(:fasta) { Helpers.fixed_fasta }

    it "returns a OpenStruct object" do
      simulate_successful_run(v)
      allow_any_instance_of(Guidance::Silencer).to receive(:execute).and_return(fasta)
      o = Guidance::Outputter.new(vault: v, report: ToolReport.new).execute.class
      expect(o).to eq(OpenStruct)
    end

    context "given a Vault without alignment and scores files" do
      it "returns OpenStruct with #successful == false" do
        v
        o = Guidance::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.successful).to be false
      end
    end

    context "given a Vault with alignment and scores files present" do
      it "returns OpenStruct with #successful == true" do
        simulate_successful_run(v)
        allow_any_instance_of(Guidance::Silencer).to receive(:execute).and_return(fasta)
        o = Guidance::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.successful).to be true
      end
      it "returns OpenStruct with alignment present" do
        simulate_successful_run(v)
        allow_any_instance_of(Guidance::Silencer).to receive(:execute).and_return(fasta)
        o = Guidance::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.alignment).to be_present
      end
      it "returns OpenStruct with alignment of String class" do
        simulate_successful_run(v)
        allow_any_instance_of(Guidance::Silencer).to receive(:execute).and_return(fasta)
        o = Guidance::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.alignment.class).to eq(String)
      end
    end

  end
end

def simulate_successful_run(vault)
  FileUtils.mkdir(vault.path_to(Guidance::OUTPUT))
  FileUtils.touch(vault.path_to(Guidance::ALIGNMENT))
  FileUtils.touch(vault.path_to(Guidance::SCORES))
end
