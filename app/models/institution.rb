class Institution < ApplicationRecord
  # Associations #
  has_many :institution_products, dependent: :destroy
  has_many :products, through: :institution_products

  # Validations #
  validates :name, :description, presence: true

  # Methods #
  def product_ids
    products.pluck(:id)
  end

  def product_ids=(ids)
    self.products = Product.find(ids.reject(&:blank?))
  end

  def product_list
    products.pluck(:name).join(', ')
  end
end
