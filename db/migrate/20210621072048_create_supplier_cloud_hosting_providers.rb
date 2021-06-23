class CreateSupplierCloudHostingProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_cloud_hosting_providers do |t|
      t.references :supplier,               foreign_key: true, index: { name: 'chp_suppliers_on_supplier_id' }
      t.references :cloud_hosting_provider, foreign_key: true, index: { name: 'chp_suppliers_on_chp_id' }

      t.timestamps
    end
  end
end
