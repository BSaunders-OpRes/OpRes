class Supplier < ApplicationRecord
  # Associations #
  belongs_to :unit

  has_one  :relationship_owner,              dependent: :destroy
  has_one  :supplier_cloud_hosting_provider, dependent: :destroy
  has_one  :cloud_hosting_provider,          through:   :supplier_cloud_hosting_provider
  has_one  :sla, as: :slaable,               dependent: :destroy

  has_many :key_contact_suppliers, dependent: :destroy
  has_many :key_contacts, through: :key_contact_suppliers
  has_many :supplier_contact_suppliers, dependent: :destroy
  has_many :supplier_contacts, through: :supplier_contact_suppliers
  has_many :technologies, dependent: :destroy
  has_many :incidents, dependent: :destroy
  has_many :supplier_steps, dependent: :destroy
  has_many :steps, through: :supplier_steps
  has_many :supplier_social_accounts, dependent: :destroy
  has_many :social_accounts, through: :supplier_social_accounts
  has_many :supplier_cloud_hosting_provider_regions, dependent: :destroy
  has_many :cloud_hosting_provider_regions, through: :supplier_cloud_hosting_provider_regions
  has_many :supplier_cloud_hosting_provider_services, dependent: :destroy
  has_many :cloud_hosting_provider_services, through: :supplier_cloud_hosting_provider_services

  # Enums #
  enum contracting_terms: %i[monthly annually other non_applicable], _suffix: :contracting_terms
  enum consumption_model: %i[iaas saas paas other], _suffix: :consumption_model
  enum party_type: %i[firm-hosted 3rd-party 4th-party]
  enum importance_level: %i[critical important]

  # Validations #
  # validates :name, :contracting_terms, presence: true

  # Nested Attributes #
  accepts_nested_attributes_for :cloud_hosting_provider, allow_destroy: true
  accepts_nested_attributes_for :relationship_owner, allow_destroy: true
  accepts_nested_attributes_for :sla, allow_destroy: true
  accepts_nested_attributes_for :supplier_social_accounts, allow_destroy: true

  # Methods #
  def party_type_color
    if send('firm-hosted?')
      'turquoise'
    elsif send('3rd-party?')
      'black'
    elsif send('4th-party?')
      'blue'
    end
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
    self.cloud_hosting_provider = CloudHostingProvider.find(id)
  end

  def cloud_hosting_provider_region_id
    cloud_hosting_provider_regions.pluck(:id)
  end

  def cloud_hosting_provider_region_id=(id)
    self.cloud_hosting_provider_regions = CloudHostingProviderRegion.find(id)
  end

  def cloud_hosting_provider_service_ids
    cloud_hosting_provider_regions.pluck(:id)
  end

  def cloud_hosting_provider_service_ids=(ids)
    self.cloud_hosting_provider_services = CloudHostingProviderService.find(ids.reject(&:blank?))
  end

  def cloud_hosting_provider_service_list
    cloud_hosting_provider_services.pluck(:name).join(', ')
  end
end
