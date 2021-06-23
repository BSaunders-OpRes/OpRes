class SupplierCloudHostingProvider < ApplicationRecord
  # Associations #
  belongs_to :supplier
  belongs_to :cloud_hosting_provider
end
