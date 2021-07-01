class CloudHostingProviderService < ApplicationRecord
  # Associations #
  belongs_to :cloud_hosting_provider
  has_many   :cloud_hosting_provider_service_recipients, dependent: :destroy
end
