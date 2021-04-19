class User < ApplicationRecord
  # Associations #
  has_many :units

  # Enums #
  enum role: %i[app_admin org_admin unit_admin user]

  # Devise #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
end
