class Organisation::BusinessServiceLinesController < Organisation::BaseController
  before_action :load_bsl, only: %i[edit update show destroy]

  def new
    @bsl = BusinessServiceLine.new
    prepare_form_data
  end

  def create
    @bsl = BusinessServiceLine.new(bsl_params)

    if @bsl.save
      redirect_to organisation_administration_portal_index_path, notice: 'Business Service Line has been created successfully.'
    else
      prepare_form_data
      render :new
    end
  end

  def edit
    prepare_form_data
  end

  def update
    if @bsl.update(bsl_params)
      redirect_to organisation_administration_portal_index_path, notice: 'Business Service Line has been updated successfully.'
    else
      prepare_form_data
      render :edit
    end
  end

  def show; end

  def destroy; end

  private

  def load_bsl
    @bsl = BusinessServiceLine.where(unit_id: managing_nodes).find(params[:id])
  end

  def prepare_form_data
    @suppliers = Supplier.where(unit_id: managing_nodes).order(id: :desc)

    @bsl.build_sla                 if @bsl.sla.blank?
    @bsl.build_material_risk_taker if @bsl.material_risk_taker.blank?
    @bsl.risk_appetites.build      if @bsl.risk_appetites.blank?
    @bsl.steps.build(number: 1)    if @bsl.steps.blank?
  end

  def bsl_params
    institution_id = organisational_unit.find_children(params[:business_service_line][:institution])
    params.require(:business_service_line).permit(:unit_id, :name, :description, :tier, product_ids: [], channel_ids: [], 
                      material_risk_taker_attributes: %i[id name title email],
                      sla_attributes: %i[id service_level_agreement service_level_objective recovery_point_objective severity1_response_time severity2_response_time severity3_response_time severity1_restoration_service_time severity2_restoration_service_time severity3_restoration_service_time severity4_restoration_service_time support_hours],
                      risk_appetites_attributes: %i[id name risk_appetite_value description creator_id _destroy],
                      steps_attributes: [:id, :name, :description, :number, :_destroy, supplier_ids: []],
                    ).merge(unit_id: institution_id.id)
  end
end
