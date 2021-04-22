class PreProduct < ApplicationRecord
  # Associations #
  has_many :pre_institution_products, dependent: :destroy
  has_many :pre_institutions, through: :pre_institution_products
  has_many :pre_product_channels, dependent: :destroy
  has_many :pre_channels, through: :pre_product_channels

  # Methods #
  def pre_channel_ids
    pre_channels.pluck(:id)
  end

  def pre_channel_ids=(ids)
    self.pre_channels = PreChannel.find(ids.reject(&:blank?))
  end

  def pre_channel_list
    pre_channels.pluck(:name).join(', ')
  end
end
