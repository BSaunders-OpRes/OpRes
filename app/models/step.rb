class Step < ApplicationRecord
  # Associations #
  belongs_to :business_service_line

  has_many :supplier_steps, dependent: :destroy
  has_many :suppliers, through: :supplier_steps

  # Validations #
  validates :name, :description, presence: true

    # Methods #
    #Suppliers
    
  def supplier_ids
    supplier.pluck(:id)
  end

  def supplier_ids=(ids)
    self.suppliers = Supplier.find(ids.reject(&:blank?))
  end

  def supplier_list
    supplier.pluck(:name).join(', ')
  end
end
