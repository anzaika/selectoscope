require 'rails_helper'

RSpec.describe Wrap::Mafft do
  describe "#execute" do
    let(:ff) { Fabricate(:simple_fasta_file) }
    let(:m)  { Wrap::Mafft.new(ff) }

    it "creates a FastaFile record after it runs" do
      ff
      expect{m.execute}.to change{FastaFile.count}.by(1)
    end

    it "creates a RunReport record after it runs" do
      expect{m.execute}.to change{RunReport.count}.by(1)
    end

    it "creates a RunReport with successful==true record after it runs" do
      m.execute
      expect(m.run_report.successful).to be_equal(true)
    end
  end
end
