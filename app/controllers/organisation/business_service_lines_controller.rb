class Organisation::BusinessServiceLinesController < Organisation::BaseController
  before_action :set_region, only: %i[find_countries]

  def index; end

  def new
    @bsl = organisational_unit .business_service_lines.new
    @bsl.build_material_risk_taker
    @bsl.build_sla()
    @bsl.risk_appetites.build
  end

  def create
    binding.pry
    @bsl = organisational_unit .business_service_lines.new(bsl_params)
    if @bsl.save
      redirect_to organisation_business_service_lines, notice: 'Business Service Line has been created successfully.'
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

  def find_institutes
  end

  private

  def set_region
    @region_unit = Unit.find_by_id params[:region_id] if params[:region_id].present?
  end

  def bsl_params
    params[:business_service_line][:tier] = params[:business_service_line][:tier].to_i
    params[:business_service_line][:sla_attributes][:support_hours] = params[:business_service_line][:sla_attributes][:support_hours].to_i
    params.require(:business_service_line).permit(:unit_id, :name, :description,
                   :tier, :region, :country, :institution,
                    material_risk_taker_attributes: [:business_service_line_id, :name, :title, :email],
                    sla_attributes: [:service_level_agreement, :service_level_objective, :recovery_point_objective, :support_hours, :severity1_response_time, :severity2_response_time, :severity3_response_time, :severity1_restoration_service_time]) 
  end
end
