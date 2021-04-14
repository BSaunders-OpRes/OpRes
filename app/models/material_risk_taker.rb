class MaterialRiskTaker < ApplicationRecord
  # Modules #
  include ContactValidation

  # Associations #
  belongs_to :business_service_line
end
