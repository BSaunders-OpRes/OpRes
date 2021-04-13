class KeyContact < ApplicationRecord
  belongs_to :unit

  has_many   :key_contact_suppliers
  has_many   :suppliers, through: :key_contact_suppliers
end
