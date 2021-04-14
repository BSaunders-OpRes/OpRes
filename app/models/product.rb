class Product < ApplicationRecord
  # Associations #
  belongs_to :unit

  has_many   :business_service_line_products 
  has_many   :business_service_lines, through: :business_service_line_products

  # Validations #
  validates :name, :description, presence: true
end
