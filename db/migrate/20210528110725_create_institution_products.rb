class CreateInstitutionProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :institution_products do |t|
      t.references :institution, foreign_key: true, index: true
      t.references :product,     foreign_key: true, index: true

      t.timestamps
    end
  end
end
