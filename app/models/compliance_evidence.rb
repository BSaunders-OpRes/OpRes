class ComplianceEvidence < ApplicationRecord
  belongs_to :supplier

  has_many :compliance_rules, dependent: :destroy
  has_one_attached :compliance_document

  enum compliance_tier: { very_high: 0, high: 1, medium: 2, low: 3 }

  validates :name, :compliance_tier, :compliance_frequency, presence: true
  validates :compliance_document, attached: true, content_type: %w(image/png image/jpg image/jpeg application/pdf application/vnd.ms-powerpoint application/vnd.ms-excel application/vnd.openxmlformats-officedocument.wordprocessingml.document)

  accepts_nested_attributes_for :compliance_rules, reject_if: :all_blank, allow_destroy: true

end
