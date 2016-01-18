module Wrap::Fast
  class Spec
    OUTPUT_FILENAME='fast_output'

    attr_reader :result_path

    # @param molphy [String] sequences in molphy format
    def initialize(molphy:, w0:, w2:, k:, p0:, p1:, tree:)
      @sequences = molphy
      @w0 = w0
      @w2 = w2
      @k = k
      @p0 = p0
      @p1 = p1
      @tree = tree

      @dir = Dir.mktmpdir
      @seq_path    = File.join(@dir, 'sequences.phy')
      @tree_path   = File.join(@dir, 'tree.nwk')
      @result_path = File.join(@dir, OUTPUT_FILENAME)
    end

    def create_files
      File.open(@seq_path,'w'){|f| f << @sequences}
      File.open(@tree_path,'w'){|f| f << @tree}
    end

    def arguments
      " -nt 1"          +
      " --debug 2"      +
      " -p w0=#{@w0}"   +
      " -p k=#{@k}"     +
      " -p p0=#{@p0}"   +
      " -p p1=#{@p1}"   +
      " -p w2=#{@w2}"   +
      " -ou #{@result_path}"   +
      " #{@tree_path}"  +
      " #{@seq_path}"
    end

    def unlink
      FileUtils.remove_entry(@dir)
    end
  end
end
