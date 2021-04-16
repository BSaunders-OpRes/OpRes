class ProductChannel < ApplicationRecord
  # Associations #
  belongs_to :product
  belongs_to :channel
end
