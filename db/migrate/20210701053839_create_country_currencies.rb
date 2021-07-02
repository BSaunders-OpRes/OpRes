class CreateCountryCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :country_currencies do |t|
      t.references :country,  foreign_key: true, index: true
      t.references :currency, foreign_key: true, index: true

      t.timestamps
    end
  end
end
