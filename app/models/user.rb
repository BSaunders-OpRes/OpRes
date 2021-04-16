class User < ApplicationRecord
  # Associations #
  has_many :units

  # Enums #
  enum role: %i[app_admin org_admin unit_admin user]

  # Validations #
  validates :name, presence: true

  # Devise #
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, stretches: 13
end
