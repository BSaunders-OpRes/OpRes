class Country < ApplicationRecord
  belongs_to :region

  def lower_alpha2
    alpha2.downcase
  end
end
