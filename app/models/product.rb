class Product < ApplicationRecord
  belongs_to :unit

  has_many   :business_service_line_products 
  has_many   :business_service_lines, through: :business_service_line_products
end
