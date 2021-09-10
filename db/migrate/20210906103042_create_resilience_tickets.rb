class CreateResilienceTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :resilience_tickets do |t|
      t.integer :rgid
      t.integer :status, default: 0
      t.string :sla_attr
      t.integer :impact
      t.references :business_service_line, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
