class CloudHostingProviderServiceRecipient < ApplicationRecord
  # Associations #
  belongs_to :cloud_hosting_provider_service
  belongs_to :chps_recipientable, polymorphic: true
end
