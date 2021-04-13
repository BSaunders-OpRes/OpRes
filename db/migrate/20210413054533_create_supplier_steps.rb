class CreateSupplierSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_steps do |t|
      t.references :step,     foreign_key: true, index: true
      t.references :supplier, foreign_key: true, index: true

      t.timestamps
    end
  end
end
