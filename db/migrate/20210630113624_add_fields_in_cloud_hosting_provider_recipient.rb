class AddFieldsInCloudHostingProviderRecipient < ActiveRecord::Migration[6.0]
  def change
    add_reference :cloud_hosting_provider_recipients,         :chp_recipientable,  polymorphic: true, index: { name: 'chp_on_recipient_id' }
    add_reference :cloud_hosting_provider_region_recipients,  :chpr_recipientable, polymorphic: true, index: { name: 'chpr_on_recipient_id' }
    add_reference :cloud_hosting_provider_service_recipients, :chps_recipientable, polymorphic: true, index: { name: 'chps_on_recipient_id' }
  end
end
