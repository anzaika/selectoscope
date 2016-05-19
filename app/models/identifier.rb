class Identifier < ActiveRecord::Base
  has_and_belongs_to_many :groups

  validates_uniqueness_of :name
  after_create :set_codename
  after_create :remove_whitespaces_from_names

  ALPHABET = ("A".."Z").to_a + (0..9).to_a

  # Make sure we have no bad chars in identifiers
  def self.transform(identifier)
    identifier.split(" ").join("_")
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

# == Schema Information
#
# Table name: identifiers
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  codename :string(10)
#
