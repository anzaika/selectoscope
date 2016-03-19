class Identifier < ActiveRecord::Base
  has_many :sequences, dependent: :destroy
  belongs_to :group

  validates_uniqueness_of :name
  after_create :set_codename

  ALPHABET = ("A".."Z").to_a + (0..9).to_a

  # Replaces all the codenames to names in the passed string
  def self.tr(string, short=false)
    Identifier.all
      .map {|o| [o.codename, short ? name_to_short(o.name) : o.name] }
      .inject(string) {|a, e| a.gsub(e.first, e.last) }
  end

  def generate_code
    (0..9).map { ALPHABET[rand(35)] }
      .join
  end

  def set_codename
    update_attribute(:codename, generate_code)
  end


  def self.name_to_short(string)
    spl = string.split("_")
    spl[1].first(7) + "..." + spl[-1]
  end
end
