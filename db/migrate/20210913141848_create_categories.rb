class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :cloud_hosting_provider_service, foreign_key: true, index: true

      t.timestamps
    end
  end
end
