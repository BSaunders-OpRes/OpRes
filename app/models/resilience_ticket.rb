class ResilienceTicket < ApplicationRecord
  # Associations #
  belongs_to :business_service_line
  belongs_to :supplier
  belongs_to :user
  belongs_to :unit

  has_many :resilience_audits, dependent: :destroy

  # Enums #
  enum status: %i[open onhold close]
  enum risk_level: %i[high medium low]

  # Methods #
  def days_open 
    (Date.parse(Time.now.to_s) - Date.parse(updated_at.to_s)).to_i
  end
end
