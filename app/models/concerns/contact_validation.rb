module ContactValidation
  extend ActiveSupport::Concern

  included do
    validates :name, :email, presence: true
    validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  end
end
