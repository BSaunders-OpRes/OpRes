class Organisation::JourneysController < Organisation::BaseController
  before_action :load_step, only: %i[show]

  def show
    log_step("Step: #{@step}")

    case @step
    when 'organisational-unit'
      log_step("Handling Step: organisational-unit")
      handle_organisational_unit
    when 'regional-unit'
      log_step("Handling Step: regional-unit")
      handle_regional_unit
    when 'country-unit'
      log_step("Handling Step: country-unit")
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
      log_step("Saving Data")
      organisational_unit.update(name: params[:name])
    end

    log_step("Picking Data")
    @regional_data  = Unit.regions
    @regional_units = Units::Regional.where(parent: organisational_unit)
  end

  def handle_country_unit
    if request.post?
      log_step("Saving Data")
      old_regional_units = Units::Regional.where(parent: organisational_unit)
      new_regional_units = []
      params[:regions].values.each do |region|
        regional_unit      = old_regional_units.find_or_initialize_by(region: region)
        regional_unit.name = Unit.build_name(organisational_unit, region)
        new_regional_units << regional_unit
      end
      Units::Regional.import(new_regional_units, on_duplicate_key_update: %i[name])
    end

    log_step("Picking Data")
    # Pick country step data
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

  def log_step(msg)
    Rails.logger.info "*"*50
    Rails.logger.info msg
    Rails.logger.info "*"*50
  end
end
