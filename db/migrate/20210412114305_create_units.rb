class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.integer :parent_id,  foreign_key: true, index: true
      t.integer :manager_id, foreign_key: true, index: true

      t.string  :type
      t.integer :unit_type

      t.string :name
      t.string :region
      t.string :country

      t.timestamps
    end
  end
end
