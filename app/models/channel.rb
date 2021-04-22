class Channel < ApplicationRecord
  # Associations #
  belongs_to :unit

  # Validations #
  validates :name, :description, :active, presence: true
end
