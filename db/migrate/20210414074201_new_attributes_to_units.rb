class NewAttributesToUnits < ActiveRecord::Migration[6.0]
  def change
    change_column :units, :region,  :string
    change_column :units, :country, :string
    add_column :units, :unit_type,  :integer
  end
end
