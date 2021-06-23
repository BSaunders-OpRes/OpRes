class SupplierSocialAccount < ApplicationRecord
  # Associations #
  has_one_attached :image, dependent: :destroy

  belongs_to :social_account
  belongs_to :supplier
end
