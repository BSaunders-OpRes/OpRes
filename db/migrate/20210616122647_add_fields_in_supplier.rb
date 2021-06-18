class AddFieldsInSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :other_description, :string
  end
end
