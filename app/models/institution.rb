class Institution < ApplicationRecord
  # Associations #
  has_many :institution_products
  has_many :products, through: :institution_products

  # Validations #
  validates :name, :description, presence: true
end
