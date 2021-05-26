class Manager < ApplicationRecord
  # Associations #
  belongs_to :user
  belongs_to :unit

  # Enums #
  enum permission: %i[super_user standard_user] 
end
