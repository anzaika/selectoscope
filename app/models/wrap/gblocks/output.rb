module Wrap::Gblocks
class Output

  def initialize(spec)
    @out = spec.result_path
  end

  def parse
    if File.exists?(@out)
      File.open(@out){|f| f.read}
    elsif
      puts '^'*20
      puts 'No gblocks output file'
      puts '^'*20
      nil
    end
  end
end
end
