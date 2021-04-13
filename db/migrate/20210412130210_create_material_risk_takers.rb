class CreateMaterialRiskTakers < ActiveRecord::Migration[6.0]
  def change
    create_table :material_risk_takers do |t|
      t.references :business_service_line, foreign_key: true, index: true

      t.string :name
      t.string :title
      t.string :email

      t.timestamps
    end
  end
end
