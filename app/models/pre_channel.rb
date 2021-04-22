class PreChannel < ApplicationRecord
  # Associations #
  has_many :pre_product_channels, dependent: :destroy
  has_many :pre_products, through: :pre_product_channels
end
