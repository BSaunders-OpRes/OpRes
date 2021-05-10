class Organisation::BusinessServiceLinesController < Organisation::BaseController
  def new
    @bsl = BusinessServiceLine.new
    @bsl.build_sla
    @bsl.build_material_risk_taker
    @bsl.risk_appetites.build
  end

  def create
    @bsl = BusinessServiceLine.new(bsl_params)

    if @bsl.save
      redirect_to organisation_administration_portal_index_path, notice: 'Business Service Line has been created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def show; end

  def destroy; end

  private

  def bsl_params
    institution_id = organisational_unit.find_children(params[:business_service_line][:institution])
    params.require(:business_service_line).permit(:unit_id, :name, :description, :tier, product_ids: [], channel_ids: [],
                      material_risk_taker_attributes: %i[name title email],
                      sla_attributes: %i[service_level_agreement service_level_objective recovery_point_objective severity1_response_time severity2_response_time severity3_response_time severity1_restoration_service_time severity2_restoration_service_time severity3_restoration_service_time severity4_restoration_service_time support_hours],
                      risk_appetites_attributes: %i[name risk_appetite_value description _destroy]
                    ).merge(unit_id: institution_id.id)
  end
end
