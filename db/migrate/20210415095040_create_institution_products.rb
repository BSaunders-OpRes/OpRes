class CreateInstitutionProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :institution_products do |t|
      t.references :institution, foreign_key: true, index: true
      t.references :product,     foreign_key: true, index: true

      t.timestamps
    end

    remove_reference :products, :unit
    add_column       :products, :active, :boolean, default: false
  end
end
