class Technology < ApplicationRecord
  # Associations #
  belongs_to :supplier

  # Validations #
  validates :name, presence: true
end
