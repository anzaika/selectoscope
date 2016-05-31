class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups, dependent: :destroy
  has_many :batches, dependent: :destroy
  has_many :run_profiles, dependent: :destroy

  USER  = "user".freeze
  ADMIN = "admin".freeze
  ROLES = %W( #{USER} #{ADMIN} ).freeze

  validates_presence_of :first_name, :last_name, :email, :role

  scope :users,  -> { where role: USER  }
  scope :admins, -> { where role: ADMIN }

  def self.roles
    ROLES
  end

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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
