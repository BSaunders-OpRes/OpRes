class Organisation::BusinessServiceLinesController < Organisation::BaseController
  before_action :set_region,   only: %i[find_countries]
  before_action :set_country, only: %i[find_institutions]
  before_action :set_product_and_channels, only: %i[find_channels_products]
  def index
    @bsls = organisational_unit.business_service_lines.order(id: :desc)
  end

  def new
    @bsl = organisational_unit.business_service_lines.new
    @bsl.build_material_risk_taker
    @bsl.build_sla()
    @bsl.risk_appetites.build
  end

  def create
    @bsl = organisational_unit .business_service_lines.new(bsl_params)
    if @bsl.save
      redirect_to organisation_business_service_lines_path, notice: 'Business Service Line has been created successfully.'
    else
      render :new
    end
  end


  def edit; end

  def update; end

  def show; end

  def destroy; end

  def find_countries
    @countries = @region_unit&.children
  end

  def find_institutions
    @institutions = @country_unit&.children
  end

  def find_channels_products
  end

  private

  def set_region
    @region_unit = Unit.find_by_id params[:region_id] if params[:region_id].present?
  end

  def set_country
    @country_unit = Unit.find_by_id params[:country_id] if params[:country_id].present?
  end

  def set_product_and_channels
    @unit      =  Unit.find_by_id params[:institution_id] if params[:institution_id].present?
    @products  =  @unit.unit_level_products
    @channels  =  Channel.joins(unit_product_channels: [:unit_product]).where(unit_products: { id: @unit.unit_products.ids })
  end

  def bsl_params
    params[:business_service_line][:tier] = params[:business_service_line][:tier].to_i
    params[:business_service_line][:sla_attributes][:support_hours] = params[:business_service_line][:sla_attributes][:support_hours].to_i
    params.require(:business_service_line).permit(:unit_id, :name, :description,
                   :tier, :region, :country, :institution,
                    material_risk_taker_attributes: [:business_service_line_id, :name, :title, :email],
                    sla_attributes: [:service_level_agreement, :service_level_objective, :recovery_point_objective, :support_hours, :severity1_response_time, :severity2_response_time, :severity3_response_time, :severity1_restoration_service_time],
                    risk_appetites_attributes: [:type, :risk_appetite_value, :description]
                    )
  end
end
