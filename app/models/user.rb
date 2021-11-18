class User < ApplicationRecord
  # Associations #
  belongs_to :unit, optional: true
  has_many :managers, dependent: :destroy
  has_many :managing_units, through: :managers, source: :unit
  has_many :risk_appetite_justifications, dependent: :nullify
  has_many :resilience_tickets, dependent: :destroy
  has_many :search_histories, dependent: :destroy
  #has_many :user_releases, dependent: :destroy
  has_many :user_notifications
  # Callbacks #
  before_validation :confirm_user

  # Attribute Accessors #
  attr_accessor :skip_password_validation

  # Enums #
  enum role: %i[application_admin root_user super_user standard_user]

  # Devise #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable, :confirmable

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

  def managing_regions
    managing_units.collect{|e| e.region.name }
  end

  def invitiable_users
    if root_user?
      User.roles.map { |k, v| [k.titleize, k] if k != 'application_admin' }.compact
    elsif super_user?
      User.roles.map { |k, v| [k.titleize, k] if k!= 'application_admin' && k!= 'root_user' }.compact
    else
      User.roles.map { |k, v| [k.titleize, k] if k!= 'application_admin' && k!= 'root_user' && k!= 'super_user' }.compact
    end
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end

  def confirm_user
    self.confirmed_at = Time.now if invited_status
  end
end
