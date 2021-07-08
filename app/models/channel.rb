class Channel < ApplicationRecord
  # Associations #
  belongs_to :unit
  has_many :unit_product_channels
  has_many :unit_products, through: :unit_product_channels
  has_many :product_channels, dependent: :destroy
  has_many :products, through: :product_channels

  # Validations #
  validates :name, :description, presence: true

  # Methods #
  def icon
    case name.downcase
    when /atm/
      'fa-credit-card'
    when /branch/
      'fa-building'
    when /phone/
      'fa-phone'
    when /web/
      'fa-globe'
    when /mobile/
      'fa-mobile'
    when /electronic trad/
      'fa-line-chart'
    when /invest/
      'fa-usd'
    else
      'fa-check'
    end
  end
end
