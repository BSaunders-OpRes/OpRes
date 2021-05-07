class BusinessServiceLine < ApplicationRecord
  # Associations #
  belongs_to :unit

  has_one  :material_risk_taker
  has_one  :sla, as: :slaable

  has_many :steps
  has_many :risk_appetites
  has_many :vulnerabilities
  has_many :business_service_line_products 
  has_many :products, through: :business_service_line_products
  has_many :business_service_line_channels
  has_many :channels, through: :business_service_line_channels

  # Enums #
  enum tier: %i[1st 2nd 3rd 4th]

  # Todo #
  # add institution in validation

  # Validations #
  validates :name, :description, :tier, presence: true

  # Nested Attributes #
  accepts_nested_attributes_for :sla
  accepts_nested_attributes_for :material_risk_taker
  accepts_nested_attributes_for :risk_appetites

    # Methods #
  def product_ids
    products.pluck(:id)
  end

  def product_ids=(ids)
    self.products = Product.find(ids.reject(&:blank?))
  end

  def product_list
    products.pluck(:name).join(', ')
  end

  def channel_ids
    channels.pluck(:id)
  end

  def channel_ids=(ids)
    self.channels = Channel.find(ids.reject(&:blank?))
  end

  def channel_list
    channels.pluck(:name).join(', ')
  end
end
