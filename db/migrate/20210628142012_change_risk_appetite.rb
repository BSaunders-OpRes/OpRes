class ChangeRiskAppetite < ActiveRecord::Migration[6.0]
  def change
    remove_column :risk_appetites, :creator_id, foreign_key: true, index: true

    rename_column :risk_appetites, :description,         :justification
    rename_column :risk_appetites, :risk_appetite_value, :amount
    change_column :risk_appetites, :amount, :float

    add_column :risk_appetites, :label, :integer, default: 0
    add_column :risk_appetites, :kind,  :integer, default: 0
  end
end
