class ChangeSupplierStatus < ActiveRecord::Migration[6.0]
  def change
    rename_column :suppliers, :status, :importance_level
  end
end
