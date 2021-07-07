class AddColumnsToSupplierStep < ActiveRecord::Migration[6.0]
  def change
    remove_column :suppliers, :party_type
    remove_column :suppliers, :importance_level

    add_column :supplier_steps, :party_type, :integer
    add_column :supplier_steps, :importance_level, :integer
  end
end
