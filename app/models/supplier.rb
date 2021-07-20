class Supplier < ApplicationRecord
  # Modules #
  include Supplier::SupplierStepConcern

  # Associations #
  belongs_to :unit

  has_one :relationship_owner,                      dependent: :destroy
  has_one :sla, as: :slaable,                       dependent: :destroy
  has_one :cloud_hosting_provider_recipient,        as: :chp_recipientable,  dependent: :destroy
  has_one :cloud_hosting_provider,                  through:   :cloud_hosting_provider_recipient
  has_one :cloud_hosting_provider_region_recipient, as: :chpr_recipientable, dependent: :destroy
  has_one :cloud_hosting_provider_region,           through:   :cloud_hosting_provider_region_recipient

  has_many :key_contact_suppliers, dependent: :destroy
  has_many :key_contacts, through: :key_contact_suppliers
  has_many :supplier_contact_suppliers, dependent: :destroy
  has_many :supplier_contacts, through: :supplier_contact_suppliers
  has_many :technologies, dependent: :destroy
  has_many :incidents, dependent: :destroy
  has_many :supplier_steps, dependent: :destroy
  has_many :steps, through: :supplier_steps
  has_many :social_account_recipients, as: :social_account_recipientable, dependent: :destroy
  has_many :social_accounts, through: :social_account_recipients
  has_many :cloud_hosting_provider_service_recipients, as: :chps_recipientable, dependent: :destroy
  has_many :cloud_hosting_provider_services, through: :cloud_hosting_provider_service_recipients
  has_many :sub_suppliers, dependent: :destroy
  has_many :third_party_suppliers,  class_name:'SubSuppliers::ThirdPartySupplier',  dependent: :destroy
  has_many :fourth_party_suppliers, class_name:'SubSuppliers::FourthPartySupplier', dependent: :destroy

  # Enums #
  enum contracting_terms: %i[monthly annually other non_applicable], _suffix: :contracting_terms
  enum consumption_model: %i[iaas paas saas other], _suffix: :consumption_model

  # Validations #
  validates :start_date, :end_date, presence: true

  # Nested Attributes #
  accepts_nested_attributes_for :cloud_hosting_provider,    allow_destroy: true
  accepts_nested_attributes_for :relationship_owner,        allow_destroy: true
  accepts_nested_attributes_for :sla,                       allow_destroy: true
  accepts_nested_attributes_for :social_account_recipients, allow_destroy: true
  accepts_nested_attributes_for :third_party_suppliers,     allow_destroy: true
  accepts_nested_attributes_for :fourth_party_suppliers,    allow_destroy: true

  # Methods #
  def strf_attr(attr)
    send(attr)&.strftime('%d.%m.%Y')
  end

  def self.real_consumption_models
    consumption_models.reject { |k, v| k == 'other' }
  end

  def key_contacts_ids
    key_contacts.pluck(:id)
  end

  def key_contacts_ids=(ids)
    self.key_contacts = KeyContact.find(ids.reject(&:blank?))
  end

  def key_contacts_list
    key_contacts.pluck(:name).join(', ')
  end

  def cloud_hosting_provider_id
    cloud_hosting_provider&.id
  end

  def cloud_hosting_provider_id=(id)
    self.cloud_hosting_provider = CloudHostingProvider.find_by(id: id)
  end

  def cloud_hosting_provider_region_id
    cloud_hosting_provider_region&.id
  end

  def cloud_hosting_provider_region_id=(id)
    self.cloud_hosting_provider_region = CloudHostingProviderRegion.find_by(id: id)
  end

  def cloud_hosting_provider_services_ids
    cloud_hosting_provider_services.pluck(:id)
  end

  def cloud_hosting_provider_services_ids=(ids)
    self.cloud_hosting_provider_services = CloudHostingProviderService.find(ids.reject(&:blank?))
  end

  def cloud_hosting_provider_services_list
    cloud_hosting_provider_services.pluck(:name).join(', ')
  end
end
