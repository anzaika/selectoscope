require "rails_helper"

RSpec.describe Phyml::Outputter do
  describe "execute" do
    let(:v) { Vault.new }
    let(:fasta) { Helpers.fixed_fasta }

    it "returns a OpenStruct object" do
      simulate_successful_run(v)
      o = Phyml::Outputter.new(vault: v, report: ToolReport.new).execute.class
      expect(o).to eq(OpenStruct)
    end

    context "given a Vault without output" do
      it "returns OpenStruct with #successful == false" do
        v
        write_std_files(v)
        o = Phyml::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.successful).to be false
      end
    end

    context "given a Vault with empty output file" do
      it "returns OpenStruct.successful == false" do
        v
        write_std_files(v)
        File.open(v.path_to(Phyml::OUTPUT), 'w') {|f| f << ""}
        o = Phyml::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.successful).to be false
      end
    end

    context "given a Vault with output file that is not empty" do
      it "returns OpenStruct with #successful == true" do
        simulate_successful_run(v)
        o = Phyml::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.successful).to be true
      end

      it "returns OpenStruct with tree present" do
        simulate_successful_run(v)
        o = Phyml::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.output).to be_present
      end

      it "returns OpenStruct with tree of String class" do
        simulate_successful_run(v)
        o = Phyml::Outputter.new(vault: v, report: ToolReport.new).execute
        expect(o.output.class).to eq(String)
      end
    end

  end
end

def simulate_successful_run(vault)
  write_std_files(vault)
  File.open(vault.path_to(Phyml::OUTPUT), 'w') {|f| f << "(a,b)"}
end

def write_std_files(vault, out="success", err="")
  File.open(vault.path_to_stdout, 'w') {|f| f << out}
  File.open(vault.path_to_stderr, 'w') {|f| f << err}
end
