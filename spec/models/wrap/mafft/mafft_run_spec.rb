require 'rails_helper'

RSpec.describe Wrap::Mafft::Run do
  describe "#execute" do
    let(:vault)  { Vault.new }

    let(:ff) { Fabricate(:simple_fasta_file) }
    let(:m)  { Wrap::Mafft::Run.new(vault, ff) }

    let(:ffcomp) { Fabricate(:complicated_fasta_file) }
    let(:mcomp)  { Wrap::Mafft::Run.new(vault, ffcomp) }

    context "for simple fasta file" do

      it "runs" do
        m.execute
      end

      it "creates a fasta file" do
        m.execute
        expect(FileTest.exist?(m.path_to_alignment)).to be(true)
      end

      it "creates a fasta file with alignment which matches the input one" do
        m.execute
        orig = ff.to_bioruby_alignment_object
        result =
          Bio::Alignment::MultiFastaFormat
            .new(File.open(m.path_to_alignment).read)
            .alignment

        expect(orig == result).to be(true)
      end

    end

    context "fox complex fasta file" do

      it "runs" do
        mcomp.execute
      end

      it "creates a fasta file with alignment that doesn't match the input one" do
        mcomp.execute
        orig = ff.to_bioruby_alignment_object
        result =
          Bio::Alignment::MultiFastaFormat
            .new(File.open(mcomp.path_to_alignment).read)
            .alignment

        expect(orig != result).to be(true)
      end

    end
  end
end
