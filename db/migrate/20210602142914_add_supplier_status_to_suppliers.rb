class AddSupplierStatusToSuppliers < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :status, :integer
  end
end
