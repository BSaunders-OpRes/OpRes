class CreateSupplierCloudHostingProviderServices < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_cloud_hosting_provider_services do |t|
      t.references :supplier,               foreign_key: true, index: { name: 'supplier_chps_on_supplier_id' }
      t.references :cloud_hosting_provider_service, foreign_key: true, index: { name: 'supplier_chps_on_chps_id' }

      t.timestamps
    end
  end
end
