class BusinessServiceLine < ApplicationRecord
  belongs_to :unit

  has_one  :material_risk_taker
  has_one  :sla, as: :slaable

  has_many :business_service_line_products 
  has_many :products, through: :business_service_line_products
  has_many :business_service_line_channels
  has_many :channels, through: :business_service_line_channels
  has_many :risk_appetites
  has_many :vulnerabilities
  has_many :steps
end
