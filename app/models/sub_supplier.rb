class SubSupplier < ApplicationRecord
  # Associations #
  belongs_to :supplier

  has_one :sla, as: :slaable, dependent: :destroy
  has_one :cloud_hosting_provider_recipient, as: :chp_recipientable,  dependent: :destroy
  has_one :cloud_hosting_provider,           through: :cloud_hosting_provider_recipient

  # Nested Attributes #
  accepts_nested_attributes_for :sla, allow_destroy: true
  accepts_nested_attributes_for :cloud_hosting_provider, allow_destroy: true

  def cloud_hosting_provider_id
    cloud_hosting_provider&.id
  end

  def cloud_hosting_provider_id=(id)
    self.cloud_hosting_provider = CloudHostingProvider.find_by(id: id)
  end
end
