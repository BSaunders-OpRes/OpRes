class Manager < ApplicationRecord
  # Associations #
  belongs_to :user
  belongs_to :unit

  # Enums #
  enum permission: %i[super_user standard_user] 

  # Callbacks #
  before_save :set_permission

  # Methods #
  private

  def set_permission
    self.permission = Manager.permissions[:super_user] if permission.blank?
  end
end
