class CreateProductChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :product_channels do |t|
      t.references :product, foreign_key: true, index: true
      t.references :channel, foreign_key: true, index: true

      t.timestamps
    end

    remove_reference :channels, :unit
    add_column       :channels, :active, :boolean, default: false
  end
end
