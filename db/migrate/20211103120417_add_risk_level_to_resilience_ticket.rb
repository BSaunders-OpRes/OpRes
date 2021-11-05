class AddRiskLevelToResilienceTicket < ActiveRecord::Migration[6.0]
  def change
    add_column :resilience_tickets, :risk_level, :integer, default: 0
  end
end
