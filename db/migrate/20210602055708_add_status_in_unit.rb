class AddStatusInUnit < ActiveRecord::Migration[6.0]
  def change
    add_column :units, :status, :integer, default: 0
  end
end
