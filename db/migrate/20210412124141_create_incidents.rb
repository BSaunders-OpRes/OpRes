class CreateIncidents < ActiveRecord::Migration[6.0]
  def change
    create_table :incidents do |t|
      t.references :supplier, foreign_key: true, index: true

      t.float    :severity
      t.datetime :date

      t.timestamps
    end
  end
end
