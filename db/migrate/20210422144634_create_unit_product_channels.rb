class CreateUnitProductChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_product_channels do |t|
      t.references :unit_product, foreign_key: true, index: true
      t.references :channel,      foreign_key: true, index: true

      t.timestamps
    end
  end
end
