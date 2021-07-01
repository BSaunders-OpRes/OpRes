class CountryCurrency < ApplicationRecord
  # Associations #
  belongs_to :country
  belongs_to :currency
end
