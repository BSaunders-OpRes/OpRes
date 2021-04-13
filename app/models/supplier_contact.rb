class SupplierContact < ApplicationRecord
  belongs_to :unit

  has_many :supplier_contact_suppliers
  has_many :suppliers, through: :supplier_contact_suppliers
end
