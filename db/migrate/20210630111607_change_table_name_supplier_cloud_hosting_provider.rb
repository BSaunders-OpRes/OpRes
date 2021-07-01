class ChangeTableNameSupplierCloudHostingProvider < ActiveRecord::Migration[6.0]
  def change
    remove_column :supplier_cloud_hosting_providers, :supplier_id
    rename_table  :supplier_cloud_hosting_providers, :cloud_hosting_provider_recipients
    remove_column :supplier_cloud_hosting_provider_regions,  :supplier_id
    rename_table  :supplier_cloud_hosting_provider_regions,  :cloud_hosting_provider_region_recipients
    remove_column :supplier_cloud_hosting_provider_services, :supplier_id
    rename_table  :supplier_cloud_hosting_provider_services, :cloud_hosting_provider_service_recipients
  end
end
