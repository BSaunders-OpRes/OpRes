class CreateSupplierContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_contacts do |t|
      t.references :unit, foreign_key: true, index: true

      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
