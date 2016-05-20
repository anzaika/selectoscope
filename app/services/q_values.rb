class ValidateQValueInputIsArraysOfEqualSize < ActiveModel::Validator
  def validate(record)
    return nil unless record.l0.size != record.l1.size
    record.errors[:base] << "L0 and L1 vectors should be of same size."
  end
end

class QValues < ActiveType::Object
  attribute :l0
  attribute :l1
  attribute :qvalues

  validates :l0, :l1, presence: true
  validates_with ValidateQValueInputIsArraysOfEqualSize

  def to_a
    qvalues
  end

  private


  def qvalues
    R.lrt = lrt
    lrt.size > 4 ? R.eval(storey) : R.eval(benjamini_hochberg)
    R.q
  end

  def lrt
    @lrt ||= l1.zip(l0).map {|a| (a.reduce(:-) * 2).to_f }
  end

  def storey
    <<-FOO
      library(qvalue)
      p = pchisq(lrt, df=1, lower.tail = F)
      q = qvalue(p, pi0.metho='bootstrap', robust=T)$qvalues
    FOO
  end

  def benjamini_hochberg
    <<-FOO
      q = p.adjust(pchisq(lrt, df=1, lower.tail = F), method='BH')
      p.adjust(q, method='BH')
    FOO
  end
end
