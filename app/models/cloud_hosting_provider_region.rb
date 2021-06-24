class CloudHostingProviderRegion < ApplicationRecord
  # Associations #
  has_many :supplier_cloud_hosting_provider_regions, dependent: :destroy
  has_many :suppliers, through: :supplier_cloud_hosting_provider_regions

  belongs_to :cloud_hosting_provider
end
