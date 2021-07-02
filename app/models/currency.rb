class Currency < ApplicationRecord
  # Associations #
  has_many :country_currencies, dependent: :destroy
  has_many :countries, through: :country_currencies
  has_many :currency_recipients, dependent: :destroy
end
