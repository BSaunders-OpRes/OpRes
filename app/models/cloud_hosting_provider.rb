class CloudHostingProvider < ApplicationRecord
  # Validations #
  validates :name, presence: true

  # Associations #
  has_many :supplier_cloud_hosting_providers, dependent: :destroy
  has_many :suppliers, through: :supplier_cloud_hosting_providers
end
