class CloudHostingProvider < ApplicationRecord
  # Validations #
  validates :name, presence: true

  # Associations #
  has_many :cloud_hosting_provider_recipients, dependent: :destroy
  has_many :cloud_hosting_provider_regions,   dependent: :destroy
  has_many :cloud_hosting_provider_services,  dependent: :destroy
end
