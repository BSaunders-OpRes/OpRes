class CreateResilienceAudits < ActiveRecord::Migration[6.0]
  def change
    create_table :resilience_audits do |t|
      t.text :description
      t.references :resilience_ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
