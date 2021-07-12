class AddNewColumnInUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :introjs, :json, default: {}
  end
end
