class Codeml
  class Runner < Wrapper::Runner
    def default_opts
      " --noisy 9" +
      " --method 1" +
      " --preset M1" +
      " #{@vault.path_to(INPUT_ALIGNMENT)}"+
      " #{@vault.path_to(INPUT_TREE)}" +
      " #{@vault.path_to(OUTPUT)}"
    end
  end
end
