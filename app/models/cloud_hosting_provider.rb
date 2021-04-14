class CloudHostingProvider < ApplicationRecord
  # Associations #
  belongs_to :supplier

  # Validations #
  validates :name, :description, presence: true
end
