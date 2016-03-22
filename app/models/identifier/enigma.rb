class Identifier::Enigma

  def initialize(group_id)
    @g = Group.find(group_id)
    @ids = @g.identifiers
  end

  def decode_string(string)
    @ids.map {|o| [o.codename, o.name] }
        .inject(string) {|a, e| a.gsub(e.first, e.last) }
  end

  def encode_string(string)
    @ids.map {|o| [o.codename, o.name] }
        .inject(string) {|a, e| a.gsub(e.last, e.first) }
  end

  def encode_file(path_to_file)
    content = File.open(path_to_file).read
    encoded = encode_string(content)
    File.open(path_to_file, 'w') { |f| f << encoded }
  end

  def decode_file(path_to_file)
    content = File.open(path_to_file).read
    decoded = decode_string(content)
    File.open(path_to_file, 'w') { |f| f << decoded }
  end

end
