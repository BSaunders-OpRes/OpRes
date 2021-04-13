class BusinessServiceLineChannel < ApplicationRecord
  belongs_to :business_service_line
  belongs_to :channel
end
