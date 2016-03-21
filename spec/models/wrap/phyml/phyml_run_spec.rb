require 'rails_helper'

RSpec.describe Wrap::Phyml::Run do
  let(:g)  { Fabricate(:group_with_alignment) }
  let(:phyml) { Wrap::Phyml::Run.new(g.id) }

  describe "#setup_files" do
    it "should copy the encoded alignment" do
      phyml.setup_files
      alignment = File.open(phyml.v.path_to(phyml.class::ALIGNMENT)).read

      original_names = g.identifiers.pluck(:name)
      encoded_names = g.identifiers.pluck(:codename)

      expect(alignment).not_to include(*original_names)
      expect(alignment).to include(*encoded_names)
    end
  end


  describe "#execute" do
    it "runs" do
      phyml.execute
    end

    it "creates an output file" do
      phyml.execute
      expect(FileTest.exist?(phyml.path_to_output)).to be(true)
    end
  end

end
