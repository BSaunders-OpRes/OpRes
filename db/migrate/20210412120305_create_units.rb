class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.references :user,      foreign_key: true, index: true
      t.integer    :parent_id, foreign_key: true, index: true

      t.string  :type

      t.string  :name
      t.integer :region
      t.integer :country

      t.timestamps
    end
  end
end
