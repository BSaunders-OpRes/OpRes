class CreateSubSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_suppliers do |t|
      t.references :supplier, foreign_key: true, index:true

      t.string :type
      t.string :name
      t.string :cloud_hosting_provider_description

      t.timestamps
    end
  end
end
