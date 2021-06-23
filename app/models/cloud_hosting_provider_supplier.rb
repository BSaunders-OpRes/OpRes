class CloudHostingProviderSupplier < ApplicationRecord
    # Associations #
  belongs_to :cloud_hosting_provider
  belongs_to :supplier
end
