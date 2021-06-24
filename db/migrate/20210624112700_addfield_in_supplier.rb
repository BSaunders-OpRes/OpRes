class AddfieldInSupplier < ActiveRecord::Migration[6.0]
  def change
    add_column :suppliers, :private_cloud_description, :string
    add_column :suppliers, :consumption_model, :integer, default: 0
    add_column :suppliers, :consumption_model_other, :string
  end
end
