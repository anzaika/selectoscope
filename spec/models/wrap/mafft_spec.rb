require 'rails_helper'

RSpec.describe Wrap::Mafft do
  describe "#execute" do
    it "creates a FastaFile record after it runs" do
      ff = Fabricate(:simple_fasta_file)
      m = Wrap::Mafft.new(ff)
      expect{m.execute}.to change{FastaFile.count}.by(1)
    end

    it "creates a RunReport record after it runs" do
      ff = Fabricate(:simple_fasta_file)
      m = Wrap::Mafft.new(ff)
      expect{m.execute}.to change{RunReport.count}.by(1)
    end

    it "creates a RunReport with successful==true record after it runs" do
      ff = Fabricate(:simple_fasta_file)
      m = Wrap::Mafft.new(ff)
      m.execute
      expect(m.run_report.successful).to be_equal(true)
    end
  end
end
