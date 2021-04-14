class SupplierStep < ApplicationRecord
  # Associations #
  belongs_to :step
  belongs_to :supplier
end
