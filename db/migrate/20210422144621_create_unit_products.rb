class CreateUnitProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_products do |t|
      t.references :unit,    foreign_key: true, index: true
      t.references :product, foreign_key: true, index: true

      t.timestamps
    end
  end
end
