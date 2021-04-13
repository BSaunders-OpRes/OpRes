class CreateKeyContactSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :key_contact_suppliers do |t|
      t.references :key_contact, foreign_key: true, index: true
      t.references :supplier,    foreign_key: true, index: true

      t.timestamps
    end
  end
end
