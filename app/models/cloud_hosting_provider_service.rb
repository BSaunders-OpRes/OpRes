class CloudHostingProviderService < ApplicationRecord
  # Associations #
  belongs_to :cloud_hosting_provider
  has_many   :cloud_hosting_provider_service_recipients, dependent: :destroy
  has_many   :categories, dependent: :destroy

  enum service_tag: %i[iaas paas saas other], _suffix: :service_tag
end
