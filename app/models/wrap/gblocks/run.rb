require 'open3'

module Wrap::Gblocks
class Run
  EXEC="Gblocks"

  def initialize(spec)
    @spec = spec
  end

  def run
    @spec.create_files
    execute
    Output.new(@spec).parse
  ensure
    @spec.unlink
  end

  private

  def execute
    Open3.popen3("#{EXEC} #{@spec.arguments}") do |i,o,e,t|
      Rails.logger.debug("Gblocks execution stdout:\n"+o.read)
      Rails.logger.debug("Gblocks execution stderr:\n"+e.read)
    end
  end

end
end
