class DnDsJob < ActiveJob::Base
  def perform(*args)
  end

  def initialize(pattern)
    @series = Series.where('pattern regexp ?', pattern)
    @pat = pattern
    @signature = @series.first.signature
    @dir = "temp_#{@signature}"

    @result_file_name = "results_#{@signature}"
    create_result_file
    puts '-'*20
    puts 'Signature: ' + @signature.to_s
    puts '-'*20
  end

  def run
    @series.each { |s| run_for_series(s) }
    # run_for_series(@series.first(4).last)
  end

  def run_for_series(s)
    create_dir
    create_sequence_file(s.processed_segments)
    copy_config
    gen_trimmed_tree
    run_codeml
    save_output
    rm
  rescue => e
    puts '*'*10
    puts 'Error when processing series: ' + s.id.to_s
    puts '-'*10
    puts 'Error: ' + e.inspect
    puts '*'*10
    exit
  end

  def path(*params)
    File.join(Rails.root, *params)
  end

  def wrk_dir(file=nil)
    p = File.join(path('tmp'), @dir)
    file ? File.join(p, file) : p
  end

  def rm
    FileUtils.remove_dir(wrk_dir)
  end

  def create_sequence_file(segments)
    File.open(wrk_dir("sequences.phy"), 'w') {|f| f << Segment.segs_to_phy(segments)}
  end

  def create_result_file
    Dir.chdir(path('tmp'))
    File.open(@result_file_name, 'w'){ |f| f << "dN\tdS\tdN/dS\n" }
  end

  def create_dir
    Dir.mkdir wrk_dir
  end

  def copy_config
    FileUtils.cp(path('codeml.ctl'), wrk_dir('codeml.ctl'))
  end

  def gen_trimmed_tree
    Dir.chdir(wrk_dir)
    FileUtils.cp path('data/2014_07_11/uni28N.nwk'), wrk_dir('big_tree.nwk')
    # `nw_clade -c 0 big_tree.nwk #{Series::TAXA.first(@signature).join(' ')} > tree.nwk`
    if @signature != 28
      `nw_prune big_tree.nwk #{Series::TAXA.last(28-@signature).join(' ')} > tree.nwk`
    else
      `mv big_tree.nwk tree.nwk`
    end
  end

  def run_codeml
    Dir.chdir wrk_dir
    `codeml`
  end

  def load_output
    File.open(wrk_dir('out'), 'r').readlines
  end

  def dn_ds
    data = load_output
    dn = data.select{|l| l.include?("tree length for dN")}.first.split(':').last.to_f
    ds = data.select{|l| l.include?("tree length for dS")}.first.split(':').last.to_f
    { dn: dn, ds: ds }
  end

  def save_output
    d = dn_ds
    File.open(path('tmp', @result_file_name), 'a') do |f|
      string = [
        d[:dn].to_s,
        d[:ds].to_s,
        d[:dn]/d[:ds]
      ].join("\t")
      f << string << "\n"
    end
  end

end
