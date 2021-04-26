class User < ApplicationRecord
  # Associations #
  belongs_to :unit, optional: true
  has_one :managing_unit, class_name: 'Unit', foreign_key: :manager_id

  # Attribute Accessors #
  attr_accessor :skip_password_validation

  # Enums #
  enum role: %i[app_admin org_admin unit_admin user]

  # Devise #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable

  # Methods #
  def name
    "#{first_name} #{last_name}"
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
