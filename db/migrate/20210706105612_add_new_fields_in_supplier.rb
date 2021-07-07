class AddNewFieldsInSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :description, :text
    add_column :suppliers, :annual_cost_of_contract, :float
  end
end
