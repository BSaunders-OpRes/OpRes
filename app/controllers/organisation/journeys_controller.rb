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
      organisational_unit.update(name: params.dig(:name))
    end
  end

  def handle_country_unit
    if request.post?
      params.dig(:regions)&.each do |region, code|
        organisational_unit.children
                           .create_with(type: Units::Regional, name: Unit.build_name('', organisational_unit.name, region))
                           .find_or_create_by(region: code)
      end
    end
  end

  def handle_institution_unit
    if request.post?
      organisational_unit.children.each do |regional_unit|
        params.dig(:countries, regional_unit.id.to_s)&.each do |country, code|
          regional_unit.children
                       .create_with(type: Units::Country, name: Unit.build_name('', organisational_unit.name, country))
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
          params.dig(:institutions, country_unit.id.to_s)&.each do |id, name|
            country_unit.children
                        .create_with(
                          type: Units::Institution,
                          name: (params.dig(:institutions_name, country_unit.id.to_s, id).presence || Unit.build_name(regional_unit.region, name, country_unit.country))
                        )
                        .find_or_create_by(institution_id: id)
          end
        end
      end
    end

    @organisational_unit = organisational_unit.include_deep_children
    @products = organisational_unit.products
    @channels = organisational_unit.channels
  end

  def handle_finish
    if request.post?
      @organisational_unit = organisational_unit.include_deep_children
      organisational_unit.children.each do |regional_unit|
        regional_unit.children.each do |country_unit|
          country_unit.children.each do |institution_unit|
            params.dig(:products, institution_unit.id.to_s)&.each do |pid, pname|
              unit_product = institution_unit.unit_products.find_or_create_by(product_id: pid)

              params.dig(:channels, institution_unit.id.to_s, pid)&.each do |cid, cname|
                unit_product.unit_product_channels.find_or_create_by(channel_id: cid)
              end
            end
          end
        end
      end
    end
  end
end
