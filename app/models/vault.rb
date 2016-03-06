require 'open3'

class Vault

  attr_reader :dir

  def initialize
    @dir = Dir.mktmpdir
    @o = File.join(@dir, 'stdout')
    @e = File.join(@dir, 'stderr')
  end

  def add(file, name)
    FileUtils.cp(file.path, File.join(@dir, name))
  end

  def path_to(filename)
    File.join(@dir, filename)
  end

  def run(exec, arguments)
    Open3.popen3("#{exec} #{arguments}") do |_i, o, e, _t|
      File.open(@o, 'w') { |f| f << o.read }
      File.open(@e, 'w') { |f| f << e.read }
    end
  end

  def destroy
    FileUtils.remove_entry(@dir)
  end
end
