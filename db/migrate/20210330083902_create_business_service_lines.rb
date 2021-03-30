class CreateBusinessServiceLines < ActiveRecord::Migration[6.0]
  def change
    create_table :business_service_lines do |t|
      t.belongs_to :organisational_unit, null: false, foreign_key: true
      t.string :name
      t.integer :tier

      t.timestamps
    end
  end
end
