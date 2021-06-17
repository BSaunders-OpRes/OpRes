class User < ApplicationRecord
  # Associations #
  belongs_to :unit, optional: true
  has_many :managers, dependent: :destroy
  has_many :managing_units, through: :managers, source: :unit

  # Attribute Accessors #
  attr_accessor :skip_password_validation

  # Enums #
  enum role: %i[application_admin root_user super_user standard_user]

  # Devise #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable

  # Methods #
  def name
    "#{first_name} #{last_name}".presence || 'User'
  end

  def initials
    _initials = "#{first_name.to_s[0] || ''}#{last_name.to_s[0] || ''}"
    _initials.upcase.presence || 'U'
  end

  def super_or_standard_user?
    super_user? || standard_user?
  end

  class << self
    def invitiable_users
      User.roles.map { |k, v| [k.titleize, k] if k != 'application_admin' }.compact
    end
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
