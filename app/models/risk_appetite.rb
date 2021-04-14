class RiskAppetite < ApplicationRecord
  # Associations #
  belongs_to :business_service_line
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  # Validations #
  validates :type, :description, :risk_appetite_value, presence: true
  validates :risk_appetite_value, numericality: true
end
