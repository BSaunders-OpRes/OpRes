class ChangeRgidToString < ActiveRecord::Migration[6.0]
  def change
    change_column :resilience_tickets, :rgid, :string
  end
end
