class SupplierCloudHostingProviderService < ApplicationRecord
  # Associations #
  belongs_to :supplier
  belongs_to :cloud_hosting_provider_service
end
