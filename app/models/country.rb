class Country < ApplicationRecord
  # Associations #
  belongs_to :region
  has_many :country_currencies, dependent: :destroy
  has_many :currencies, through: :country_currencies

  # Methods #
  def lower_alpha2
    alpha2.downcase
  end
end
