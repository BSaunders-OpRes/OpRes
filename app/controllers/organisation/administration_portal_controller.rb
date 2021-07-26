class Organisation::AdministrationPortalController < Organisation::BaseController
  before_action :load_search_data, only: %i[index]

  def index
    @bsls = BusinessServiceLine.where(unit_id: managing_nodes).order(id: :desc)
    @bsls = @bsls.where('business_service_lines.name iLike ?', "%#{params.dig(:bsl, :name)}%")                       if params.dig(:bsl, :name).present?
    @bsls = @bsls.where(tier: params.dig(:bsl, :tiers))                                                              if params.dig(:bsl, :tiers).present?
    @bsls = @bsls.where(unit_id: params.dig(:bsl, :institution_units))                                               if params.dig(:bsl, :institution_units).present?
    @bsls = @bsls.joins(unit: [parent: [:parent]]).where(parents_units_2: { id: params.dig(:bsl, :regional_units) }) if params.dig(:bsl, :regional_units).present?
    @bsls = @bsls.joins(:products).where(products: { id: params.dig(:bsl, :products) })                              if params.dig(:bsl, :products).present?

    @suppliers = Supplier.where(unit_id: managing_nodes).order(id: :desc)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def load_search_data
    managing_country_units
    managing_institution_units
  end
end
