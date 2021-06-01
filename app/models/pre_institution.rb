class PreInstitution < ApplicationRecord
  # Associations #
  has_many :pre_institution_products, dependent: :destroy
  has_many :pre_products, through: :pre_institution_products

  # Enums #
  enum unit_type: %i[bank building_society insurer designated_investment_firm payments_services_institution recognised_investment_exchange electronic_money_institution enhanced_scope_senior_managers_and_certification_regime]

  # Methods #
  def pre_product_ids
    pre_products.pluck(:id)
  end

  def pre_product_ids=(ids)
    self.pre_products = PreProduct.find(ids.reject(&:blank?))
  end

  def pre_product_list
    pre_products.pluck(:name).join(', ')
  end
end
