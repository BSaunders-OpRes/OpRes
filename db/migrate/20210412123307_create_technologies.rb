class CreateTechnologies < ActiveRecord::Migration[6.0]
  def change
    create_table :technologies do |t|
      t.references :supplier, foreign_key: true, index: true

      t.string :name

      t.timestamps
    end
  end
end
