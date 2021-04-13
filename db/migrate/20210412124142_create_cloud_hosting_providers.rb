class CreateCloudHostingProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :cloud_hosting_providers do |t|
      t.references :supplier, foreign_key: true, index: true

      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
