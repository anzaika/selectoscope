require "rails_helper"

RSpec.describe Guidance::Outputter do
  let(:v) { Vault.new }
  describe "execute" do
    context "given a Vault with succesfull run" do
      it "returns a path to filtered alignment" do

        fas = Helpers.fixed_fasta
        FileUtils.mkdir(File.join(v.dir, Guidance::OUTPUT))
        v.write_to_file(fas, Guidance::FILTERED_ALIGNMENT)

        o = Guidance::Outputter.new({vault: v, report: report})
        out = o.execute
        expect(FileTest.exist?(out)).to eq(true)
      end
    end
  end
end
