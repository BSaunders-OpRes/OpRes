class Channel < ApplicationRecord
  # Associations #
  belongs_to :unit
  has_many :unit_product_channels
  has_many :unit_products, through: :unit_product_channels

  # Validations #
  validates :name, :description, presence: true
end
