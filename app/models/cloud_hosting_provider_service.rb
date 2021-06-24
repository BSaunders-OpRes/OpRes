class CloudHostingProviderService < ApplicationRecord
    # Associations #
  has_many :supplier_cloud_hosting_provider_services, dependent: :destroy
  has_many :suppliers, through: :supplier_cloud_hosting_provider_services

  belongs_to :cloud_hosting_provider
end
