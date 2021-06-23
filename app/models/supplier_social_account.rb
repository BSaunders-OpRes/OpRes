class SupplierSocialAccount < ApplicationRecord
  # Associations #
  belongs_to :social_account
  belongs_to :supplier
end
