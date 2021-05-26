class Region < ApplicationRecord
  has_many :countries, dependent: :destroy

  def lower_name
    name.downcase
  end
end
