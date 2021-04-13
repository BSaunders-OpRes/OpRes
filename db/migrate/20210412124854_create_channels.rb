class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.references :unit, foreign_key: true, index: true

      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
