class CloudHostingProviderRegionRecipient < ApplicationRecord
   # Associations #
  belongs_to :cloud_hosting_provider_region
  belongs_to :chpr_recipientable, polymorphic: true
end
