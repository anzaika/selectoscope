# == Schema Information
#
# Table name: trees
#
#  id            :integer          not null, primary key
#  newick        :binary(65535)
#  treeable_id   :integer          not null
#  treeable_type :string(20)       not null
#
# Indexes
#
#  index_trees_on_treeable_id_and_treeable_type  (treeable_id,treeable_type)
#

require 'rails_helper'

RSpec.describe Tree, type: :model do
  # describe '#fast_inn_node_names' do
  #   it 'works' do
  #     pending
  #     t = build(:tree,
  #               newick: '(A,B,(C,(D,E)*1)*0);')
  #     t.fast_inn_node_names.should == %w(1 0)
  #   end
  # end
end
