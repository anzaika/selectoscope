module FastOutput
  class SetBranchQvalues
    def initialize(branches)
      @branches = branches
      run
    end

    def run
      l0 = branches.map(&:l0)
      l1 = branches.map(&:l1)
      qvalues = QValues.create(l0: l0, l1: l1).to_a
      branches.each_with_index {|b, i| b.q = qvalues[i] }
    end
  end
end
