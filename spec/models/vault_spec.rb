require 'rails_helper'

RSpec.describe Vault do
  describe "#new" do
    it "creates a temporary directory" do
      v = Vault.new
      expect{Vault.new}.to change{Dir['/tmp/*'].count}.by(1)

    end
  end

  describe "#add" do
    it "copies the file to the directory with desired name" do
      v = Vault.new
      ff = Fabricate(:simple_fasta_file)
      v.add(ff.file.path, 'fasta.fasta')
      files = Dir[File.join(v.dir, "/*")]
      file = File.join(v.dir, "fasta.fasta")
      expect(files).to include(file)
    end
  end

  describe "#execute" do
    it "should run a block of code inside the temp directory" do
      v = Vault.new
      file = File.join(v.dir, "hello.txt")
      v.execute('touch', file)
      files = Dir[File.join(v.dir, "/*")]
      expect(files).to include(file)
    end
  end

  describe "#destroy" do
    it "removes a temporary directory" do
      v = Vault.new
      expect{v.destroy}.to change{Dir['/tmp/*'].count}.by(-1)
    end
  end
end
