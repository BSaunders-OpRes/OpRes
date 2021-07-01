class CloudHostingProviderRegion < ApplicationRecord
  # Associations #
  belongs_to :cloud_hosting_provider
  has_many   :cloud_hosting_provider_region_recipients, dependent: :destroy
end
