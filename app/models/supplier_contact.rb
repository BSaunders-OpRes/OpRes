class SupplierContact < ApplicationRecord
  # Associations #
  # belongs_to :unit
  belongs_to :supplier
  has_many :supplier_contact_suppliers
  has_many :suppliers, through: :supplier_contact_suppliers

  # Validations #
  validates :name, :email, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
