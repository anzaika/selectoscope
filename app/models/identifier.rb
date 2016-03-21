class Identifier < ActiveRecord::Base
  has_and_belongs_to_many :groups

  validates_uniqueness_of :name
  after_create :set_codename
  after_create :remove_whitespaces_from_names

  ALPHABET = ("A".."Z").to_a + (0..9).to_a

  def self.decode_string(group_id, string)
    Group.find(group_id)
         .identifiers
         .map {|o| [o.codename, o.name] }
         .inject(string) {|a, e| a.gsub(e.first, e.last) }
  end

  def self.encode_string(group_id, string)
    Group.find(group_id)
         .identifiers
         .map {|o| [o.codename, o.name] }
         .inject(string) {|a, e| a.gsub(e.last, e.first) }
  end

  private

  def generate_code
    (0..9).map { ALPHABET[rand(35)] }
      .join
  end

  def set_codename
    code = generate_code
    while Identifier.where(codename: code).count > 0 do
      code = generate_code
    end
    update_attribute(:codename, generate_code)
  end

  def remove_whitespaces_from_names
    new_name = name.split(" ").join("_")
    self.update_attribute(:name, new_name)
  end

end
