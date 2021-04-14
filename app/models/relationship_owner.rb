class RelationshipOwner < ApplicationRecord
  # Modules #
  include ContactValidation

  # Associations #
  belongs_to :supplier
end
