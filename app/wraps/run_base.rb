class RunBase

  def v
    @v ||= Vault.new
  end

  def execute
    setup_files
    run
  end

  def setup_files
  end

  def args
  end

  def path_to_output
    v.path_to(self.class::OUTPUT)
  end

  private

  def run
    v.run(self.class::EXEC, args)
  end
end
