class PreInstitution < ApplicationRecord
  # Associations #
  has_many :pre_institution_products, dependent: :destroy
  has_many :pre_products, through: :pre_institution_products

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
