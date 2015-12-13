class Sequence < ActiveRecord::Base
  belongs_to :group, counter_cache: true
  belongs_to :identifier, counter_cache: true

  validates_presence_of :sequence, :group, :identifier

  def seq_with_id
    s = Bio::Sequence.auto(sequence)
    s.definition = identifier.id
    s
  end

  def seq_with_name
    s = Bio::Sequence.auto(sequence)
    s.definition = identifier.name
    s
  end

  def seq_with_codename
    s = Bio::Sequence.auto(sequence)
    s.definition = identifier.codename
    s
  end

  def aa
    seq.translate
  end

  def short_seq
    sequence.first(20) +
      " ... " +
      sequence.last(20)
  end
end
