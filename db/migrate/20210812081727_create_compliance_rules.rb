class CreateComplianceRules < ActiveRecord::Migration[6.0]
  def change
    create_table :compliance_rules do |t|
      t.string      :title
      t.integer     :reminder
      t.string      :email_address
      t.text        :tailored_message
      t.references  :compliance_evidence, foreign_key: true, index: true

      t.timestamps
    end
  end
end
