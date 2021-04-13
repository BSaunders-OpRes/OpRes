class CreateBusinessServiceLines < ActiveRecord::Migration[6.0]
  def change
    create_table :business_service_lines do |t|
      t.references :unit, foreign_key: true, index: true

      t.string  :name
      t.text    :description
      t.integer :tier
      t.integer :region
      t.integer :country
      t.string  :institution

      t.timestamps
    end
  end
end
