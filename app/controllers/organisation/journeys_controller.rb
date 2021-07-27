require 'csv'

class Organisation::JourneysController < Organisation::BaseController
  before_action :load_step_data, only: %i[show]

  def show
    authorize! :can_do_onboarding, Journey
    if request.post?
      Journey::SaveDataService.call({
        organisational_unit: organisational_unit,
        region_operator:     @region_operator,
        regional_unit:       @regional_unit,
        country_operator:    @country_operator,
        country_unit:        @country_unit,
        params:              params
      })

      @organisational_unit = organisational_unit.include_children
      @regional_unit&.reload
      @country_unit&.reload
    end

    handle_get_request

    respond_to do |format|
      format.html {}
      format.js   {}
    end
  end

  def build_institution
    @institution  = Institution.find(params[:institution])
    @index        = params[:index].to_i
  end

  private

  ##################
  # Load Main Data #
  def load_step_data
    @step, region_name, country_alpha2 = params[:id].split('/')

    if region_name.present?
      @region_operator = Region.find_by(name: region_name.upcase)
      @regional_unit   = organisational_unit.find_children_by_region(@region_operator.id)
    end

    if country_alpha2.present?
      @country_operator = Country.find_by(alpha2: country_alpha2.upcase)
      @country_unit     = organisational_unit.find_children_by_country(@country_operator.id)
    end
  end

  #############
  # Load Data #
  def handle_get_request
    case @step
    when 'welcome'
    when 'organisation'
    when 'regions'
      @all_regions = Region.all
    when 'account_setup'
    when 'countries'
      @all_countries = @region_operator.countries
    when 'country_setup'
    when 'institutions'
      @all_institutions = organisational_unit.institutions.includes(products: [:channels])
    when 'invite_user'
    when 'finish'
    end
  end
end
