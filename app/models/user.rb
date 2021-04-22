require 'bcrypt'

class User < ApplicationRecord
  # Associations #
  has_many :units

  # Enums #
  enum role: %i[app_admin org_admin unit_admin user]

  # Devise #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # Methods #
  class << self
    def valid_password?(password, pass_hash)
      BCrypt::Password.new(pass_hash) == password
    end
  end
end
