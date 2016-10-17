class Phyml
  class Outputter < Wrapper::Outputter
    def run_successful?
      FileTest.exist?(@vault.path_to(OUTPUT)) &&
      !File.open(@vault.path_to(OUTPUT)).read.empty?
    end
  end
end
