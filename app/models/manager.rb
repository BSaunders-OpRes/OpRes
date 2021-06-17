class Manager < ApplicationRecord
  # Associations #
  belongs_to :user
  belongs_to :unit
end
