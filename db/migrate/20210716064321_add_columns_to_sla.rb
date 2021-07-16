class AddColumnsToSla < ActiveRecord::Migration[6.0]
  def change
    add_column :slas, :transactions_per_second, :float
    add_column :slas, :response_time,           :float
  end
end
