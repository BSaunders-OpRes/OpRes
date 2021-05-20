class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.references :region, foreign_key: true, index: true

      t.string  :continent
      t.string  :alpha2
      t.string  :alpha3
      t.string  :country_code
      t.string  :international_prefix
      t.string  :ioc
      t.string  :gec
      t.string  :name
      t.json    :national_destination_code_lengths
      t.json    :national_number_lengths
      t.string  :national_prefix
      t.string  :number
      t.string  :region_name
      t.string  :subregion
      t.string  :world_region
      t.string  :un_locode
      t.string  :nationality
      t.boolean :postal_code
      t.string  :postal_code_format
      t.json    :unofficial_names
      t.json    :languages_official
      t.json    :languages_spoken
      t.json    :geo
      t.string  :currency_code
      t.string  :start_of_week
      t.json    :translations
      t.json    :translated_names

      t.timestamps
    end
  end
end
