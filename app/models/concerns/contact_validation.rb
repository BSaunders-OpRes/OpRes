module ContactValidation
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :email, format: { with: Devise::email_regexp }, if: -> { email.present? }
  end
end
