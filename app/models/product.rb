class Product < ApplicationRecord
  # Associations #
  belongs_to :unit

  # Validations #
  validates :name, :description, presence: true
end
