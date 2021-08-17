class CreateComplianceEvidences < ActiveRecord::Migration[6.0]
  def change
    create_table :compliance_evidences do |t|
      t.string      :name
      t.text        :description
      t.integer     :compliance_tier
      t.integer     :compliance_frequency, default: 365
      t.references  :supplier,             foreign_key: true, index: true

      t.timestamps
    end
  end
end
