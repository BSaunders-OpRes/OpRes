class Channel < ApplicationRecord
  # Associations #
  belongs_to :unit

  has_many   :business_service_line_channels 
  has_many   :business_service_lines, through: :business_service_line_channels

  # Validations #
  validates :name, :description, presence: true
end
