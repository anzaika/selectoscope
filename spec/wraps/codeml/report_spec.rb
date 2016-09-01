# require 'rails_helper'
#
# RSpec.describe Codeml::Report do
#   let(:ff) { Fabricate(:simple_fasta_file) }
#   let(:g)  { Fabricate(:group_with_tree_and_alignment) }
#   let(:codeml) { Codeml::Run.new(g.id)}
#   let(:codeml_rep) { codeml.execute; Codeml::Report.new(codeml)}
#
#   describe "#save" do
#     it "runs" do
#       g
#       codeml_rep.save
#     end
#
#     it "creates a CodemlResult record" do
#       g
#       codeml_rep
#       expect{codeml_rep.save}.to change{CodemlResult.count}.from(0).to(1)
#     end
#   end
#
# end
