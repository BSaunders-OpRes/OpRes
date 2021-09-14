class AddUnitToResilienceTicket < ActiveRecord::Migration[6.0]
  def change
    add_reference :resilience_tickets, :unit, foreign_key: true
  end
end
