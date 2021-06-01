class InstitutionProduct < ApplicationRecord
  # Associations #
  belongs_to :institution
  belongs_to :product
end
