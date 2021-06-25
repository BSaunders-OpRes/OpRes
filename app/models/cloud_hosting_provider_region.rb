class CloudHostingProviderRegion < ApplicationRecord
  # Associations #
  belongs_to :cloud_hosting_provider

  has_many :supplier_cloud_hosting_provider_regions, dependent: :destroy
  has_many :suppliers, through: :supplier_cloud_hosting_provider_regions
end
