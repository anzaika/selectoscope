class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, dependent: :destroy
  has_many :batches, dependent: :destroy

  USER  = "user"
  ADMIN = "admin"
  ROLES = %W( #{USER} #{ADMIN} )

  validates_presence_of :first_name, :last_name, :email, :role

  scope :users,  -> { where role: USER  }
  scope :admins, -> { where role: ADMIN }

  def name
    first_name + " " + last_name
  end

  def admin?
    role == ADMIN
  end

  def user?
    role == USER
  end

  def self.generate_password
    glossary.sample(8).join
  end

  def self.glossary
    (0..9).to_a +
    ("a".."z").to_a +
    ("A".."Z").to_a +
    ["!", "?", "#", "%", "*", "&"]
  end
end
