class CreateOrganisationalUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :organisational_units do |t|
      t.string :name
      t.string :geographic_region
      t.string :country

      t.timestamps
    end
  end
end
