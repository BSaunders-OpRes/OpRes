class BusinessServiceLine < ApplicationRecord

  # Modules #
  include ResilienceConcern

  # Associations #
  belongs_to :unit

  has_one  :material_risk_taker, dependent: :destroy
  has_one  :sla, as: :slaable,   dependent: :destroy
  has_one  :currency_recipient, as: :currency_recipientable, dependent: :destroy
  has_one  :currency, through: :currency_recipient

  has_many :steps,           dependent: :destroy
  has_many :risk_appetites,  dependent: :destroy
  has_many :vulnerabilities, dependent: :destroy
  has_many :business_service_line_products, dependent: :destroy
  has_many :products, through: :business_service_line_products
  has_many :business_service_line_channels, dependent: :destroy
  has_many :channels, through: :business_service_line_channels
  has_many :resilience_tickets, dependent: :destroy

  # Enums #
  enum tier: %i[tier_1 tier_2 tier_3 tier_4]

  # Validations #
  validates :name, :description, :tier, presence: true

  # Custom Validations #
  validate :custom_validation

  # Nested Attributes #
  accepts_nested_attributes_for :sla, allow_destroy: true
  accepts_nested_attributes_for :material_risk_taker, allow_destroy: true
  accepts_nested_attributes_for :risk_appetites, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

  #callbacks #
  after_save :create_resilience_tickets

  # Methods #
  def reoder_steps
    steps.each_with_index do |step, index|
      step.update(number: index + 1)
    end
  end

  def critical_supplier_steps
    SupplierStep.joins(step: [:business_service_line])
                .includes(:supplier, :step)
                .where(business_service_lines: { id: id })
                .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] })
  end

  def important_supplier_steps
    SupplierStep.joins(step: [:business_service_line])
                .includes(:supplier, :step)
                .where(business_service_lines: { id: id })
                .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] })
  end

  def supplier_steps
    SupplierStep.joins(step: [:business_service_line])
                .includes(:supplier, :step)
                .where(business_service_lines: { id: id })
  end

  def organisational_unit
    unit.parent.parent.parent
  end

  def region
    unit.parent.parent
  end

  def country
    unit.parent
  end

  def institution
    unit.institution
  end

  def organisation_users
    organisational_unit.users
  end

  def organisation_root_users
    organisation_users.root_user
  end

  def product_ids
    products.pluck(:id)
  end

  def product_ids=(ids)
    self.products = Product.find(ids.reject(&:blank?))
  end

  def product_list
    products.pluck(:name).join(', ')
  end

  def channel_ids
    channels.pluck(:id)
  end

  def channel_ids=(ids)
    self.channels = Channel.find(ids.reject(&:blank?))
  end

  def channel_list
    channels.pluck(:name).join(', ')
  end

  def currency_id
    currency&.id
  end

  def currency_id=(id)
    self.currency = Currency.find_by(id: id)
  end

  def custom_validation
    risk_appetites&.each do |risk_appetite|
      if risk_appetite.percentage_amount?
        if !risk_appetite&.amount.nil? && !sla[risk_appetite.kind.to_sym] && risk_appetite&.amount > sla[risk_appetite.kind.to_sym]
          self.errors[:base] << "Risk Appetite does not meet the requirement of target value."
        end
      else
        if !risk_appetite&.amount.nil? && !sla[risk_appetite.kind.to_sym] && risk_appetite&.amount  < sla[risk_appetite.kind.to_sym]
          self.errors[:base] << "Risk Appetite does not meet the requirement of target value."
        end
      end
    end
  end

  private

  def create_resilience_tickets
    supplier_steps&.each do |supplier_step|
      risk_appetites.each do |risk_appetite|
        bsl_sla_val       = sla[risk_appetite.kind]
        supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
        if bsl_sla_val && supplier_sla_val && risk_appetite_val
          if risk_appetite.percentage_amount?
            result = find_score_and_status_for_percentage(sla[risk_appetite.kind], supplier_step.supplier.sla[risk_appetite.kind], risk_appetite.amount)
          else
            result = find_score_and_status_for_time(sla[risk_appetite.kind], supplier_step.supplier.sla[risk_appetite.kind], risk_appetite.amount)
          end
          if result[1] == 'exceed'
            resilience_id = ResilienceTicket.where(unit: unit.parent)&.last&.rgid.present? ? (ResilienceTicket.where(unit: unit.parent).last.rgid&.split('-')[1].to_i+1).to_s :  '100000'.to_s
            unless ResilienceTicket.find_by(sla_attr: risk_appetite.kind, business_service_line: self, unit: unit.parent, supplier: supplier_step.supplier)
              self.resilience_tickets << ResilienceTicket.create( user: self.organisation_root_users.first, rgid: 'RES-'+resilience_id, sla_attr: risk_appetite.kind, business_service_line: self, unit: unit.parent, supplier: supplier_step.supplier)
            end
          else
            # for destroying the ticket which is not exceeding now
            ResilienceTicket.find_by(sla_attr: risk_appetite.kind,business_service_line: self, unit: unit.parent, supplier: supplier_step.supplier)&.destroy
          end
        end
      end
    end
  end
end
