class Fastcodeml
  class Outputter < Wrapper::Outputter
    def run_successful?
      FileTest.exist?(@vault.path_to(OUTPUT))
    end
  end
end
