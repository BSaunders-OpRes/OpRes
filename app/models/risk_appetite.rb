class RiskAppetite < ApplicationRecord
  # Associations #
  belongs_to :business_service_line
  has_many :risk_appetite_justifications, dependent: :destroy

  # Enums #
  # Kind enum is based on the SLA columns. In future introduce user defined kind.
  enum kind:  %w[service_level_agreement service_level_objective recovery_time_objective recovery_point_objective severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration]
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

  class << self
    def kind_display_name
      {
        service_level_agreement: 'SLA', service_level_objective: 'SLO', recovery_time_objective: 'RTO', recovery_point_objective: 'RPO',
        severity1: 'Severity 1', severity2: 'Severity 2', severity3: 'Severity 3', severity4: 'Severity 4',
        severity1_restoration: 'Restoration Severity 1', severity2_restoration: 'Restoration Severity 2',
        severity3_restoration: 'Restoration Severity 3', severity4_restoration: 'Restoration Severity 4'
      }.stringify_keys
    end
  end
end
