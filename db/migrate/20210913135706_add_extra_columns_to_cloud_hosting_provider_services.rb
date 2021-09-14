class AddExtraColumnsToCloudHostingProviderServices < ActiveRecord::Migration[6.0]
  def change
    add_column :cloud_hosting_provider_services, :service_tag, :integer, default: 0
    add_column :cloud_hosting_provider_services, :description, :text
  end
end
