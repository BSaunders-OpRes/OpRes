class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.belongs_to :organisational_unit, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
