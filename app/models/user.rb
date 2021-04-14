class User < ApplicationRecord
  # Associations #
  has_many :units

  # Enums #
  enum role: %i[org_admin unit_admin user]

  # Validations #
  validates :name, presence: true
end
