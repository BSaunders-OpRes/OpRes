class CreateSuppliers < ActiveRecord::Migration[6.0]
  def change
    create_table :suppliers do |t|
      t.references :unit, foreign_key: true, index: true

      t.string  :name
      t.integer :contracting_terms

      t.timestamps
    end
  end
end
