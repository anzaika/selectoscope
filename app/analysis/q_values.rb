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
    R.lrt = l1.zip(l0).map {|a| a.reduce(:-) * 2 }
    R.eval(script)
    R.q
  end

  def script
    <<-FOO
      library(qvalue)
      p = pchisq(lrt, df=1, lower.tail = F)
      q = qvalue(p, pi0.metho='bootstrap', robust=T)$qvalues
    FOO
  end
end
