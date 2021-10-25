class Supplier < ApplicationRecord
  require 'CSV'
  # Modules #
  include Suppliers::SupplierStepConcern
  include ResilienceConcern


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
  has_many :compliance_evidences, dependent: :destroy
  has_many :resilience_tickets,   dependent: :destroy

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

  # callbacks #
  after_save :create_resilience_tickets

  # Methods #
  def self.import(file, organsational_unit)
    CSV.foreach(file.path, headers: true) do |row|
      spl_hash = Supplier.new
      spl_hash.name = row[0]
      spl_hash.contracting_terms = row[1]
      spl_hash.contracting_terms_other = row[2]
      spl_hash.start_date = row[3]
      spl_hash.end_date = row[4]
      spl_hash.description = row[5]
      spl_hash.annual_cost_of_contract = row[6]
      spl_hash.cloud_hosting_provider_id = find_chp(row[7])
      spl_hash.cloud_hosting_provider_region_id = find_chp_region(row[8])
      row[9]&.split(",").each do |e|
        spl_hash.cloud_hosting_provider_service_ids << CloudHostingProviderService.find_by(name: e)&.id
      end
      spl_hash.sla_attributes = {slaable_type: row[10], slaable_id: find_slaable_id(row[11]), service_level_agreement: row[12], service_level_objective: row[13], recovery_point_objective: row[14], transactions_per_second: row[15], recovery_time_objective: row[16], response_time: row[17], severity1: row[18], severity2: row[19], severity3: row[20], severity4: row[21], severity1_restoration: row[22], severity2_restoration: row[23], severity3_restoration: row[24], severity4_restoration: row[25], support_hours: row[26], support_hours_other: row[27]}
      spl_hash.relationship_owner_attributes = {supplier_id: find_supplier_by_name(row[28]), name: row[29], email: row[30], job_title: row[31]}
      spl_hash.unit_id = organsational_unit.inclusive_children.map{|e| e if e.type == "Units::Country"}.compact.first.id
      spl_hash.save
    end
  end

  def strf_attr(attr)
    send(attr)&.strftime('%d.%m.%Y')
  end
  def self.find_chp_region(name)
    CloudHostingProviderRegion.find_by(name:name)&.id
  end

  def self.find_chp(name)
    CloudHostingProvider.find_by(name:name)&.id
  end

  def self.find_slaable_id(name)
    Supplier.find_by(name: name)&.id || BusinessServiceLine.find_by(name: name)&.id  
  end

  def self.find_supplier_by_name(name)
    Supplier.find_by(name: name)&.id
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

  def party_type
    supplier_steps.first&.party_type
  end

  def key_contacts_list
    key_contacts.pluck(:name).join(', ')
  end

  def bsls_count
    steps.pluck(:business_service_line_id).size
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

  private

  def create_resilience_tickets

    bsls = BusinessServiceLine.joins(steps: [supplier_steps: [:supplier]])
                              .where(suppliers: {id: id})
                              .includes(:sla)

    bsls.each do |bsl|
      bsl.excluded_risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
        if bsl_sla_val && supplier_sla_val && risk_appetite_val
          if risk_appetite.percentage_amount?
            result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind], sla[risk_appetite.kind], risk_appetite.amount)
          else
            result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind], sla[risk_appetite.kind], risk_appetite.amount)
          end
          if result[1] == 'exceed'
            resilience_id = ResilienceTicket.where(unit: unit)&.last&.rgid.present? ? (ResilienceTicket.where(unit: unit).last.rgid&.split('-')[1].to_i+1).to_s :  '100000'.to_s
            unless ResilienceTicket.find_by(sla_attr: risk_appetite.kind, business_service_line: bsl, unit: unit, supplier: self)
              self.resilience_tickets << ResilienceTicket.create( user: bsl.organisation_root_users.first, rgid: 'RES-'+resilience_id, sla_attr: risk_appetite.kind, business_service_line: bsl, unit: unit, supplier: self)
            end
          else
            # for destroying the ticket which is not exceeding now
            ResilienceTicket.find_by(sla_attr: risk_appetite.kind, business_service_line: bsl, unit: unit, supplier: self)&.destroy
          end
        end
      end
    end
  end
end
