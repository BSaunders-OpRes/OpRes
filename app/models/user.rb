class User < ApplicationRecord
  # Associations #
  belongs_to :unit, optional: true
  has_one :managing_unit, class_name: 'Unit', foreign_key: :manager_id

  # Enums #
  enum role: %i[app_admin org_admin unit_admin user]

  # Devise #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable,
         :trackable
end
