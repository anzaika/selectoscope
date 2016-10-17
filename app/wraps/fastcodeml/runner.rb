class Fastcodeml
  class Runner < Wrapper::Runner
    def default_opts
      " --no-pre-stop"               \
      " -nt 4"                       \
      " -v 4"                        \
      " -ou #{@vault.path_to(OUTPUT)}"   \
      " #{@vault.path_to(INPUT_TREE)}"         \
      " #{@vault.path_to(INPUT_ALIGNMENT)}"
      # " -p k=#{codeml.k}"            \
    end
  end
end
