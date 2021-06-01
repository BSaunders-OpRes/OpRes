class Product < ApplicationRecord
  # Associations #
  belongs_to :unit
  has_many :unit_products
  has_many :units, through: :unit_products

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
