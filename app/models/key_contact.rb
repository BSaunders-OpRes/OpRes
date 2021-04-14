class KeyContact < ApplicationRecord
  # Modules #
  include ContactValidation

  # Associations #
  belongs_to :unit

  has_many   :key_contact_suppliers
  has_many   :suppliers, through: :key_contact_suppliers
end
