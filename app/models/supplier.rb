class Supplier < ApplicationRecord
  # Associations #
  belongs_to :unit

  has_one  :relationship_owner
  has_one  :cloud_hosting_provider
  has_one  :sla, as: :slaable

  has_many :key_contact_suppliers
  has_many :key_contacts, through: :key_contact_suppliers
  has_many :supplier_contact_suppliers
  has_many :supplier_contacts, through: :supplier_contact_suppliers
  has_many :technologies
  has_many :incidents
  has_many :supplier_steps
  has_many :steps, through: :supplier_steps

  # Enums #
  enum contracting_terms: %i[monthly annually]

  # Validations #
  validates :name, :contracting_terms, presence: true
  validates :contracting_terms, numericality: { only_integer: true }
end
