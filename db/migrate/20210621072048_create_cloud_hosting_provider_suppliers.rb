class CreateCloudHostingProviderSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :cloud_hosting_provider_suppliers do |t|
      t.references :cloud_hosting_provider, foreign_key: true, index: { name: 'chp_suppliers_on_chp_id' }
      t.references :supplier,               foreign_key: true, index: { name: 'chp_suppliers_on_supplier_id' }

      t.timestamps
    end
  end
end
