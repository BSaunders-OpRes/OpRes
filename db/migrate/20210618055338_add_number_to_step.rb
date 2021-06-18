class AddNumberToStep < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :number, :integer
  end
end
