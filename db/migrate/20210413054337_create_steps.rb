class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.references :business_service_line, foreign_key: true, index: true

      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
