class CreateProductChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :product_channels do |t|
      t.references :product, foreign_key: true, index: true
      t.references :channel, foreign_key: true, index: true

      t.timestamps
    end
  end
end
