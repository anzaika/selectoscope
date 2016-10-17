class Phyml
  class Runner < Wrapper::Runner
    def default_opts
      "-q -i #{@vault.path_to(INPUT_ALIGNMENT)}"
    end
  end
end
