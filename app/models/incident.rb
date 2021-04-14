class Incident < ApplicationRecord
  # Associations #
  belongs_to :supplier

  # Validations #
  validates :severity, :date, presence: true
  validates :severity, numericality: true
end
