class Product < ApplicationRecord
  # Associations #
  belongs_to :unit
  has_many :unit_products
  has_many :units, through: :unit_products

  # Validations #
  validates :name, :description, presence: true
end
