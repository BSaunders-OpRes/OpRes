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
    when 'institution-unit'
      handle_institution_unit
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
      params[:regions]&.each do |region, code|
        organisational_unit.children
                           .create_with(type: Units::Regional, name: Unit.build_name(organisational_unit, region))
                           .find_or_create_by(region: code)
      end
    end
  end

  def handle_institution_unit
    if request.post?
      organisational_unit.children.each do |regional_unit|
        params[:countries][regional_unit.id.to_s]&.each do |country, code|
          regional_unit.children
                       .create_with(type: Units::Country, name: Unit.build_name(organisational_unit, country))
                       .find_or_create_by(country: code)
        end
      end
    end

    @institution_data = organisational_unit.institutions
  end

  def product_step
  end

  def channel_step
  end

  def finish_wizard_path
    # user_path(current_user)
  end
end
