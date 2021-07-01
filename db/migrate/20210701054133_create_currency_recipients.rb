class CreateCurrencyRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_recipients do |t|
      t.references :currency
      t.references :currency_recipientable, polymorphic: true, index: { name: 'currency_recipient_on_recipientable_type_id' }

      t.timestamps
    end

    add_column :business_service_lines, :cost_centre_id, :string
  end
end
