require 'rails_helper'

RSpec.describe FastResult::Output do
  let(:g) { Fabricate(:group_with_good_fast) }
  let(:out) { FastResult::Output.new(g.fast_result.id) }

  describe '.initialize' do
    it "works" do
      out
    end
  end

  describe '#process' do
    it "works" do
      out.process
    end
  end
end
