class Organisation::UnitsController < Organisation::BaseController
  def load_countries
    @regional_unit = organisational_unit.find_children(params[:regional_unit_id])
  end

  def load_institutions
    @country_unit = organisational_unit.find_children(params[:country_unit_id])
  end

  def load_products_channels
    @institution_unit = organisational_unit.find_children(params[:institution_unit_id])
    return if @institution_unit.blank?

    @products = @institution_unit.unit_level_products.distinct
    @channels = Channel.joins(unit_product_channels: [:unit_product]).where(unit_products: { id: @institution_unit.unit_products.ids }).distinct
  end
end
