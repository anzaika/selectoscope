require "rails_helper"

RSpec.describe Phyml::Preparer do
  describe "execute" do
    context "being send a FASTA formatted string" do
      it "writes it to a file inside the vault" do
        v = Vault.new
        fas = Helpers.fasta
        r = Phyml::Preparer.new({vault: v, input: fas})
        r.execute
        expect(File.open(v.path_to(Phyml::INPUT)).read).to eq(fas)
      end
    end
  end
end
