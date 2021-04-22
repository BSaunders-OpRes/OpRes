class UnitProduct < ApplicationRecord
  # Associations #
  belongs_to :unit
  belongs_to :product

  has_many :unit_product_channels
  has_many :channels, through: :unit_product_channels
end
