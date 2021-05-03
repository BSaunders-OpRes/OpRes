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
    when 'product-channel'
      handle_product_channel
    when 'finish'
      handle_finish
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

    @institutions = organisational_unit.institutions
  end

  def handle_product_channel
    if request.post?
      organisational_unit.children.each do |regional_unit|
        regional_unit.children.each do |country_unit|
          params[:institutions][country_unit.id.to_s]&.each do |id, name|
            country_unit.children
                        .create_with(type: Units::Institution, name: name)
                        .find_or_create_by(institution_id: id)
          end
        end
      end
    end

    @products = organisational_unit.products
    @channels = organisational_unit.channels
  end

  def handle_finish
  end
end
