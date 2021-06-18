class Supplier < ApplicationRecord
  # Associations #
  belongs_to :unit

  has_one  :relationship_owner,     dependent: :destroy
  has_one  :cloud_hosting_provider, dependent: :destroy
  has_one  :sla, as: :slaable,      dependent: :destroy

  has_many :key_contact_suppliers, dependent: :destroy
  has_many :key_contacts, through: :key_contact_suppliers
  has_many :supplier_contact_suppliers, dependent: :destroy
  has_many :supplier_contacts, through: :supplier_contact_suppliers
  has_many :technologies, dependent: :destroy
  has_many :incidents, dependent: :destroy
  has_many :supplier_steps, dependent: :destroy
  has_many :steps, through: :supplier_steps

  # Enums #
  enum contracting_terms: %i[monthly annually other non-applicable]
  enum party_type: %i[3rd-party 4th-party]
  enum status: %i[critical important]

  # Validations #
  # validates :name, :contracting_terms, presence: true

  # Nested Attributes #
  accepts_nested_attributes_for :cloud_hosting_provider, allow_destroy: true
  accepts_nested_attributes_for :relationship_owner, allow_destroy: true
  accepts_nested_attributes_for :sla, allow_destroy: true

  # Methods #
  def key_contacts_ids
    key_contacts.pluck(:id)
  end

  def key_contacts_ids=(ids)
    self.key_contacts = KeyContact.find(ids.reject(&:blank?))
  end

  def key_contacts_list
    key_contacts.pluck(:name).join(', ')
  end
end
