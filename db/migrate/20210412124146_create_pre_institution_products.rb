class CreatePreInstitutionProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :pre_institution_products do |t|
      t.references :pre_institution, foreign_key: true, index: true
      t.references :pre_product,     foreign_key: true, index: true

      t.timestamps
    end
  end
end
