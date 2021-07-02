class SocialAccountRecipient < ApplicationRecord
  # Associations #
  belongs_to :social_account
  belongs_to :social_account_recipientable, polymorphic: true
end
