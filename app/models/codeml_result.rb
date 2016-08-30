class CodemlResult < ActiveRecord::Base
  belongs_to :group
  has_one :text_file, as: :textifilable, dependent: :destroy
  has_one :tree, as: :treeable, dependent: :destroy

  def output
    File.open(text_file.file.path).read
  end

  def process_output
    process
    save_processed_params
  end

  private

  def process
    File.open(text_file.file.path) do |f|
      f.readlines.each { |l| parse_line(l) }
    end
  end

  def parse_line(l)
    if l =~ /^kappa \(ts\/tv\) =/
      @k = l.split('=').last.to_f
    elsif l =~ /^\(.+: ([0-9]*\.[0-9]+|[0-9]), \(.+:/
      @tree = l.chomp.squish
    elsif l =~ /^p:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
      @p0 = l.split(' ')[1].to_f
      @p1 = l.split(' ')[2].to_f
    elsif l =~ /^w:\s+ ([0-9]*\.[0-9]+|[0-9])\s+([0-9]*\.[0-9]+|[0-9])$/
      @w0 = l.split(' ')[1].to_f
      @w1 = l.split(' ')[2].to_f
    end
  end

  def save_processed_params
    self.update_attributes(k: @k, p0: @p0, p1: @p1, w0: @w1, w1: @w1)
    Tree.create(newick: @tree, treeable: self)
  end
end

# == Schema Information
#
# Table name: codeml_results
#
#  id       :integer          not null, primary key
#  k        :float(24)
#  w0       :float(24)
#  w1       :float(24)
#  p0       :float(24)
#  p1       :float(24)
#  group_id :integer
#
# Indexes
#
#  index_codeml_results_on_group_id  (group_id)
#
