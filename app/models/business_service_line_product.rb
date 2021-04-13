class BusinessServiceLineProduct < ApplicationRecord
  belongs_to :business_service_line
  belongs_to :product
end
