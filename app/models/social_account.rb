class SocialAccount < ApplicationRecord
  # Associations #
  has_one_attached :logo, dependent: :destroy

  has_many :supplier_social_accounts, dependent: :destroy
  has_many :suppliers, through: :supplier_social_accounts
end
