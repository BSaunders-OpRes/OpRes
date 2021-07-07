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
    @suppliers  = Supplier.where(unit_id: managing_nodes).order(id: :desc)
    @currencies = Currency.all

    @bsl.build_sla                 if @bsl.sla.blank?
    @bsl.build_material_risk_taker if @bsl.material_risk_taker.blank?
    @bsl.steps.build(number: 1)    if @bsl.steps.blank?

    RiskAppetite.kinds.each do |k, v|
      # FIX: N + 1
      @bsl.risk_appetites.build(
        name: "#{RiskAppetite.kind_display_name[k]} Risk Appetite Rules Engine",
        kind: k
      ) if @bsl.risk_appetites.send(k).blank?
    end
  end

  def bsl_params
    institution_unit = organisational_unit.find_children(params[:business_service_line][:institution])

    params.dig(:business_service_line, :risk_appetites_attributes).each do |index, raa|
      raa.dig(:risk_appetite_justifications_attributes, '0').merge!(user_id: current_user.id) if raa.dig(:risk_appetite_justifications_attributes, '0', :justification).present?
    end

    params.require(:business_service_line)
          .permit(:unit_id, :name, :description, :tier, :cost_centre_id, :currency_id,
            product_ids: [], channel_ids: [],
            material_risk_taker_attributes: %i[id name title email],
            sla_attributes: %i[id service_level_agreement service_level_objective recovery_point_objective recovery_time_objective severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration support_hours support_hours_other],
            steps_attributes: [:id, :name, :description, :number, :_destroy, supplier_ids: []],
            risk_appetites_attributes: [:id, :name, :amount, :label, :kind, :_destroy, risk_appetite_justifications_attributes: %i[user_id justification]]
          ).merge(unit_id: institution_unit.id)
  end
end
