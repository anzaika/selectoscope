require 'rails_helper'

RSpec.describe Phyml::Report do
  let(:ff) { Fabricate(:simple_fasta_file) }
  let(:g)  { Fabricate(:group_with_alignment) }
  let(:phyml) { Phyml::Run.new(g.id)}
  let(:phyml_rep) { phyml.execute; Phyml::Report.new(phyml)}

  describe "#save" do
    it "runs" do
      phyml
      phyml_rep.save
    end

    it "creates a Tree record" do
      g
      phyml_rep
      expect{phyml_rep.save}.to change{Tree.count}.from(0).to(1)
    end

    it "the tree identifiers should be decoded" do
      g
      phyml_rep.save

      original_names = g.identifiers.pluck(:name)
      encoded_names = g.identifiers.pluck(:codename)

      expect(g.tree.newick).to include(*original_names)
      expect(g.tree.newick).not_to include(*encoded_names)
    end
  end

end
