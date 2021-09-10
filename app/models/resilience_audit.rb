class ResilienceAudit < ApplicationRecord

  # Associations #
  belongs_to :resilience_ticket

  has_one_attached :attachment

  #Validations #
  validates :description, presence: true
  # validates :attachment, attached: true, content_type: %w(image/png image/jpg image/jpeg application/pdf application/vnd.ms-powerpoint application/vnd.ms-excel application/vnd.openxmlformats-officedocument.wordprocessingml.document)
end
