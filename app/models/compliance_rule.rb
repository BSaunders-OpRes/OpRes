class ComplianceRule < ApplicationRecord
  belongs_to :compliance_evidence

  validates :title, :reminder, :email_address, :tailored_message, presence: true
end
