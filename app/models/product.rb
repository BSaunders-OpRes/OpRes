class Product < ApplicationRecord
  # Associations #
  has_many :institution_products, dependent: :destroy
  has_many :institutions, through: :institution_products
  has_many :product_channels, dependent: :destroy
  has_many :channels, through: :product_channels

  # Validations #
  validates :name, :description, presence: true

  # Methods #
  def channel_ids
    channels.pluck(:id)
  end

  def channel_ids=(ids)
    self.channels = Channel.find(ids.reject(&:blank?))
  end

  def channel_list
    channels.pluck(:name).join(', ')
  end
end
