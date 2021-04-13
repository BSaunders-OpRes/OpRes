class Step < ApplicationRecord
  belongs_to :business_service_line

  has_many :supplier_steps
  has_many :suppliers, through: :supplier_steps
end
