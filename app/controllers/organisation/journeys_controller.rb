class Organisation::JourneysController < Organisation::BaseController
  def index; end

  def regional_step
    organisational_unit.update(units_organisational_params)
  end

  def country_step
    return if params[:regions].blank?

    regional_units = []
    params[:regions].values.each do |region|
      regional_units << Units::Regional.new(
        parent: organisational_unit,
        region: region,
        name:   Units::Regional.build_name(organisational_unit, region)
      )
    end
    Units::Regional.import(regional_units)
    @regional_units = Units::Regional.where(parent: organisational_unit)
  end

  def institution_step
    countries_units = []
    regions         = Unit::regions
    regions&.each do |region|
      countries = params[region] && params.dig(region).values.first

      countries&.each do |country|
        countries_units << Units::Country.new(
          parent_id: params.dig(region).keys.first.to_i,
          region:    region,
          name:      Units::Country.build_name(organisational_unit, country)
        )
      end
      Units::Country.import(countries_units, on_duplicate_key_ignore: true)
    end
  end

  def product_step
  end

  def channel_step
  end

  private

  def units_organisational_params
    params.require(:units_organisational).permit(:name)
  end

  def finish_wizard_path
    # user_path(current_user)
  end
end
