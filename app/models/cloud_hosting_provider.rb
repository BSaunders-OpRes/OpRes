class CloudHostingProvider < ApplicationRecord
  # Validations #
  validates :name, presence: true

  # Associations #
  has_many :cloud_hosting_provider_suppliers, dependent: :destroy
  has_many :suppliers, through: :cloud_hosting_provider_suppliers
end
