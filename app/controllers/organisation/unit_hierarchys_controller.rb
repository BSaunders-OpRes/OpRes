class Organisation::UnitHierarchysController < Organisation::BaseController
  def load_countries
    @regional_unit = organisational_unit.find_children(params[:regional_unit_id])
  end

  def load_institutions
    @country_unit = organisational_unit.find_children(params[:country_unit_id])
  end

  def load_products_channels
    @institution_unit = organisational_unit.find_children(params[:institution_unit_id])
  end
end
