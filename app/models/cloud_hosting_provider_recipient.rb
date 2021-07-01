class CloudHostingProviderRecipient < ApplicationRecord
  # Associations #
  belongs_to :cloud_hosting_provider
  belongs_to :chp_recipientable, polymorphic: true
end
