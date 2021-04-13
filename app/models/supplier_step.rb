class SupplierStep < ApplicationRecord
  belongs_to :step
  belongs_to :supplier
end
