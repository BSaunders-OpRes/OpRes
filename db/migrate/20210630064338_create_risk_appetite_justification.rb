class CreateRiskAppetiteJustification < ActiveRecord::Migration[6.0]
  def change
    remove_column :risk_appetites, :justification

    create_table :risk_appetite_justifications do |t|
      t.references :risk_appetite, foreign_key: true, index: true
      t.references :user,          foreign_key: true, index: true

      t.text :justification

      t.timestamps
    end
  end
end
