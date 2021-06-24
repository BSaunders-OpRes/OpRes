class Step < ApplicationRecord
  # Associations #
  belongs_to :business_service_line

  has_many :supplier_steps, dependent: :destroy
  has_many :suppliers, through: :supplier_steps

  # Validations #
  validates :name, :description, presence: true

  # Scopes #
  default_scope { order(number: :asc) }

  # Callbacks #
  after_destroy :reoder_steps

  # Methods #
  def reoder_steps
    business_service_line.reoder_steps
  end

  def supplier_ids
    suppliers.pluck(:id)
  end

  def supplier_ids=(ids)
    self.suppliers = Supplier.find(ids.reject(&:blank?))
  end

  def supplier_list
    suppliers.pluck(:name).join(', ')
  end
end
