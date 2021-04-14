class SupplierContactSupplier < ApplicationRecord
  # Associations #
  belongs_to :supplier_contact
  belongs_to :supplier
end
