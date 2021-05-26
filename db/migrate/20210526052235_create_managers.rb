class CreateManagers < ActiveRecord::Migration[6.0]
  def change
    remove_column :units, :manager_id, :integer
    remove_column :units, :region,     :string
    remove_column :units, :country,    :string

    add_reference :units, :region,  foreign_key: true, index: true
    add_reference :units, :country, foreign_key: true, index: true

    create_table :managers do |t|
      t.references :user, foreign_key: true, index: true
      t.references :unit, foreign_key: true, index: true

      t.integer :permission

      t.timestamps
    end
  end
end
