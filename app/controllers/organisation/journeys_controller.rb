class Organisation::JourneysController < Organisation::BaseController
  before_action :load_step, only: %i[show]

  def show
    case @step
    when 'organisational-unit'
      handle_organisational_unit
    when 'regional-unit'
      handle_regional_unit
    when 'country-unit'
      handle_country_unit
    end

    respond_to do |format|
      format.html {}
      format.js   {}
    end
  end

  private

  def load_step
    @step = params[:id]
  end

  def handle_organisational_unit; end

  def handle_regional_unit
    if request.post?
      organisational_unit.update(name: params[:name])
    end
  end

  def handle_country_unit
    if request.post?
      params[:regions].values.each do |region|
        organisational_unit.children
                           .create_with(type: Units::Regional, name: Unit.build_name(organisational_unit, region))
                           .find_or_create_by(region: region)
      end
    end
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

  def finish_wizard_path
    # user_path(current_user)
  end
end
