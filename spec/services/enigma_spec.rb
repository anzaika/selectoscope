require "rails_helper"

RSpec.describe Enigma do
  describe "decode_file" do
    context "given a group and a text file with encoded strings" do
      let (:group) { Fabricate(:group) }
      let (:enigma) { Enigma.new(group.id) }
      let (:file) do
        file = Tempfile.new('seq.fasta')
        file.write(group.identifiers.pluck(:codename).join("\n"))
        file.rewind
        file
      end

      it "should replace all names with codenames" do
        group
        file
        enigma.decode_file(file.path)
        decoded_content = file.read
        group.identifiers.pluck(:name).each do |name|
          expect(decoded_content.include?(name)).to be true
        end
      end

      it "and leave no codenames behind" do
        group
        file
        enigma.decode_file(file.path)
        decoded_content = file.read
        group.identifiers.pluck(:codename).each do |codename|
          expect(decoded_content.include?(codename)).to be false
        end
      end

    end
  end
end
