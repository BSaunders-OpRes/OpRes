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
