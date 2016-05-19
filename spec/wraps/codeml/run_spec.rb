require 'rails_helper'

RSpec.describe Codeml::Run do
  let(:ff) { Fabricate(:simple_fasta_file) }
  let(:g)  { Fabricate(:group_with_tree_and_alignment) }
  let(:codeml) { Codeml::Run.new(g.id)}

  describe "#execute" do
    it "creates an output file" do
      pending
      codeml.execute
      expect(FileTest.exist?(codeml.path_to_output)).to be true
    end
  end

end
