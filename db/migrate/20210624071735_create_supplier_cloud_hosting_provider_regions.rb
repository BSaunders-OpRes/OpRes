class CreateSupplierCloudHostingProviderRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_cloud_hosting_provider_regions do |t|
      t.references :supplier,                      foreign_key: true, index: { name: 'supplier_chpr_on_supplier_id' }
      t.references :cloud_hosting_provider_region, foreign_key: true, index: { name: 'supplier_chpr_on_chp_id' }

      t.timestamps
    end
  end
end
