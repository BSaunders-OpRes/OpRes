class RiskAppetite < ApplicationRecord
  # Associations #
  belongs_to :business_service_line
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id, optional: true

  # Validations #
  validates :name, :description, :risk_appetite_value, presence: true
  validates :risk_appetite_value, numericality: true

  def creator_info
    "#{creator.name} #{created_at.strftime('%dth %B %Y %H:%M')}"
  end
end
