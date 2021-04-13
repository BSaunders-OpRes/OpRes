class Channel < ApplicationRecord
  belongs_to :unit

  has_many   :business_service_line_channels 
  has_many   :business_service_lines, through: :business_service_line_channels
end
