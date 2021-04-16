class Product < ApplicationRecord
  # Associations #
  has_many :institution_products
  has_many :institutions, through: :institution_products
  has_many :product_channels
  has_many :channels, through: :product_channels

  # Validations #
  validates :name, :description, presence: true
end
