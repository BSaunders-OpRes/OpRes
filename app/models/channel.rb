class Channel < ApplicationRecord
  # Associations #
  has_many :product_channels
  has_many :products, through: :product_channels

  # Validations #
  validates :name, :description, :active, presence: true
end
