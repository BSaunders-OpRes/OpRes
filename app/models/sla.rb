class Sla < ApplicationRecord
  # Associations #
  belongs_to :slaable, polymorphic: true

  # Enums #
  enum support_hours: %i[24/7 24/5 18/7 18/5 other]

  # Constants #
  SLA_ATTR = %w[service_level_agreement service_level_objective recovery_point_objective recovery_point_objective
                severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration
                severity4_restoration recovery_time_objective
               ]
  # Validations #
  # validates :service_level_agreement, :service_level_objective, :support_hours, :recovery_point_objective,
  #           :severity1_response_time, :severity2_response_time, :severity3_response_time, :severity4_response_time,
  #           :severity1_restoration_service_time, :severity2_restoration_service_time, :severity3_restoration_service_time,
  #           :severity4_restoration_service_time, presence: true, numericality: { only_integer: true}
end
