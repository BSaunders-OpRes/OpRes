class CloudHostingProvider < ApplicationRecord
  # Validations #
  validates :name, presence: true

  # Associations #
  has_many :supplier_cloud_hosting_providers, dependent: :destroy
  has_many :suppliers, through: :supplier_cloud_hosting_providers
  has_many :cloud_hosting_provider_regions,   dependent: :destroy
  has_many :cloud_hosting_provider_services,  dependent: :destroy

end
