class CreateRiskAppetites < ActiveRecord::Migration[6.0]
  def change
    create_table :risk_appetites do |t|
      t.references :business_service_line, foreign_key: true, index: true

      t.integer :creator_id, foreign_key: true, index: true
      t.string  :type
      t.text    :description
      t.integer :risk_appetite_value

      t.timestamps
    end
  end
end
