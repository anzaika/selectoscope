require 'rails_helper'

RSpec.describe Wrap::Mafft::Report do
  describe "#save" do
    let(:vault)  { Vault.new }

    let(:ff) { Fabricate(:simple_fasta_file) }
    let(:m)  { Wrap::Mafft::Run.new(vault, ff) }
    let(:mrep)  { m.execute; Wrap::Mafft::Report.new(vault, m) }

    let(:ffcomp) { Fabricate(:complicated_fasta_file) }
    let(:mcomp)  { Wrap::Mafft::Run.new(vault, ffcomp) }
    let(:mrepcomp)  { mcomp.execute; Wrap::Mafft::Report.new(vault, mcomp) }

    it "runs" do
      mrep.save
    end

    it "creates a RunReport record" do
      expect{mrep.save}.to change{RunReport.count}.by(1)
    end

    it "creates a RunReport with successful==true" do
      mrep.save
      expect(RunReport.last.successful).to be_equal(true)
    end

    it "creates a FastaFile" do
      mrep
      expect{mrep.save}.to change{FastaFile.count}.by(1)
    end

    it "creates a FastaFile record with correct alignment" do
      mrep.save
      orig_ff = ff.to_bioruby_alignment_object
      aligned_ff = FastaFile.last.to_bioruby_alignment_object
      expect(orig_ff == aligned_ff).to be(true)
    end

    it "doesn't just copy-paste the original alignment" do
      ffcomp
      mrepcomp.save
      orig_ff = ffcomp.to_bioruby_alignment_object
      aligned_ff = FastaFile.last.to_bioruby_alignment_object
      expect(orig_ff == aligned_ff).to be(false)
    end

    it "creates the Alignment record" do
      mrep
      expect{mrep.save}.to change{Alignment.count}.by(1)
    end

    it "a run report should be linked to alignment" do
      mrep.save
      expect(Alignment.last.run_reports.count).to be(1)
    end
  end
end
