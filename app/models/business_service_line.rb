class BusinessServiceLine < ApplicationRecord
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

  # Enums #
  enum tier: %i[tier_1 tier_2 tier_3 tier_4]

  # Validations #
  validates :name, :description, :tier, presence: true

  # Nested Attributes #
  accepts_nested_attributes_for :sla, allow_destroy: true
  accepts_nested_attributes_for :material_risk_taker, allow_destroy: true
  accepts_nested_attributes_for :risk_appetites, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true

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
end
