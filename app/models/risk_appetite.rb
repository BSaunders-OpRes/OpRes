class RiskAppetite < ApplicationRecord
  # Associations #
  belongs_to :business_service_line
  has_many :risk_appetite_justifications, dependent: :destroy

  # Enums #
  # Kind enum is based on the SLA columns. In future introduce user defined kind.
  enum kind:  %w[service_level_agreement service_level_objective recovery_time_objective recovery_point_objective transactions_per_second response_time severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration]
  enum label: %w[very_low low medium high very_high]

  # Validations #
  validates :name, :kind, :label, presence: true
  validates :amount, numericality: true, allow_nil: true

  # Nested Attributes #
  accepts_nested_attributes_for :risk_appetite_justifications, reject_if: :all_blank, allow_destroy: true

  # Scopes #
  default_scope { order(id: :asc) }

  # Methods #
  def percentage_amount?
    kind.in? %w[service_level_agreement service_level_objective]
  end

  def minutes_amount?
    kind.in? %w[recovery_time_objective recovery_point_objective severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration]
  end

  def tps_amount?
    kind.in? %w[transactions_per_second]
  end

  def ms_amount?
    kind.in? %w[response_time]
  end

  class << self
    def kind_display_name
      {
        service_level_agreement: 'SLA', service_level_objective: 'SLO', recovery_time_objective: 'RTO', recovery_point_objective: 'RPO',
        transactions_per_second: 'TPS', response_time: 'Response Time',
        severity1: 'Incident Notification Severity 1', severity2: 'Incident Notification Severity 2', severity3: 'Incident Notification Severity 3', severity4: 'Incident Notification Severity 4',
        severity1_restoration: 'Incident Restoration Severity 1', severity2_restoration: 'Incident Restoration Severity 2',
        severity3_restoration: 'Incident Restoration Severity 3', severity4_restoration: 'Incident Restoration Severity 4'
      }.stringify_keys
    end
  end
end
