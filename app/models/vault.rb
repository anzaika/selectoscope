require 'open3'

class Vault

  attr_reader :dir

  STDOUT = "stdout.out"
  STDERR = "stderr.out"

  def initialize
    @dir = Dir.mktmpdir
    @o = File.join(@dir, STDOUT)
    @e = File.join(@dir, STDERR)
  end

  def path_to_stdout
    @o
  end

  def path_to_stderr
    @e
  end

  def write_to_file(content, filename)
    File.open(path_to(filename), 'w') { |f| f << content }
  end

  def add(file, name)
    FileUtils.cp(file.path, File.join(@dir, name))
  end

  def path_to(filename)
    File.join(@dir, filename)
  end

  def run(exec, arguments)
    Open3.popen3("cd #{@dir} && #{exec} #{arguments}") do |i, o, e, _t|
      i.puts "y\r\n"
      File.open(@o, 'w') { |f| f << o.read }
      File.open(@e, 'w') { |f| f << e.read }
    end
  end

  def file_list
    Dir.entries(@dir).select {|f| !File.directory? f}.join(", ")
  end

  def destroy
    FileUtils.remove_entry(@dir)
  end
end
