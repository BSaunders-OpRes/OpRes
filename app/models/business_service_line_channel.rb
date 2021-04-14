class BusinessServiceLineChannel < ApplicationRecord
  # Associations #
  belongs_to :business_service_line
  belongs_to :channel
end
