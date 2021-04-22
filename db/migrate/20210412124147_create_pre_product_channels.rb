class CreatePreProductChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :pre_product_channels do |t|
      t.references :pre_product, foreign_key: true, index: true
      t.references :pre_channel, foreign_key: true, index: true

      t.timestamps
    end
  end
end
