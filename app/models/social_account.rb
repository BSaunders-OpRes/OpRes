class SocialAccount < ApplicationRecord
  # Associations #
  has_one_attached :logo, dependent: :destroy
  has_many :social_account_recipients, dependent: :destroy
end
