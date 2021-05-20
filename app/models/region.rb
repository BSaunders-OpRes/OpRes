class Region < ApplicationRecord
  has_many :countries, dependent: :destroy
end
