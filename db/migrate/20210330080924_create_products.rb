class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.belongs_to :organisational_unit, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
