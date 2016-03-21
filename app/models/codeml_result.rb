class CodemlResult < ActiveRecord::Base
  belongs_to :group
  has_one :text_file, as: :textifilable

  def process(l)
    if l =~ /^kappa \(ts\/tv\) =/
      @k = l.split('=').last.to_f
    elsif l =~ /^\(.+: ([0-9]*\.[0-9]+|[0-9]), \(.+:/
      @tree = l.chomp
    elsif l =~ /^p:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
      @p0 = l.split(' ')[1].to_f
      @p1 = l.split(' ')[2].to_f
    elsif l =~ /^w:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
      @w0 = l.split(' ')[1].to_f
      @w1 = l.split(' ')[2].to_f
    end
  end
end
