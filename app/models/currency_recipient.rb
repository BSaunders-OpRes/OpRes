class CurrencyRecipient < ApplicationRecord
  # Associations #
  belongs_to :currency
  belongs_to :currency_recipientable, polymorphic: true
end
