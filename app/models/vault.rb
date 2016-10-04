require "open3"

class Vault
  attr_reader :dir
  include Util::Tar

  STDOUT = "stdout.out".freeze
  STDERR = "stderr.out".freeze

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
    File.open(path_to(filename), "w") {|f| f << content }
  end

  # Copy path from file into vault with desired name
  def add(path_to_file, name)
    FileUtils.cp(path_to_file, File.join(@dir, name))
  end

  def path_to(filename)
    File.join(@dir, filename)
  end

  def execute(exec, arguments)
    Open3.popen3("cd #{@dir} && #{exec} #{arguments}") do |i, o, e, _t|
      i.puts "y\r\n"
      File.open(@o, "w") {|f| f << o.read }
      File.open(@e, "w") {|f| f << e.read }
    end
  end

  def file_list
    Dir.glob("#{@dir}/**/*")
  end

  def destroy
    FileUtils.remove_entry(@dir)
  end

  # TODO: temp implementation, needs fixing
  def archive
    io = tar(@dir)
    gz = gzip(io)
    File.open("/opt/app/log/demo.tar.gz", "wb") {|f| f << gz}
  end
end
