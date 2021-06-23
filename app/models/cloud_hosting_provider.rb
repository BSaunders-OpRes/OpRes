class CloudHostingProvider < ApplicationRecord
  # Validations #
  validates :name, presence: true
end
