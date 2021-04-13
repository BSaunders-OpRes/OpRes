class CreateSupplierContactSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_contact_suppliers do |t|
      t.references :supplier_contact, foreign_key: true, index: true
      t.references :supplier,         foreign_key: true, index: true

      t.timestamps
    end
  end
end
