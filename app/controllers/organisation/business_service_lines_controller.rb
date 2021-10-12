class Organisation::BusinessServiceLinesController < Organisation::BaseController
  before_action :load_bsl, only: %i[edit update show destroy
                                    critical_important_suppliers compound_resilience cloud_service_provider
                                    find_chp_data]

  load_and_authorize_resource except: [:create, :bsl_critical_important_supplier]

  def new
    @bsl = BusinessServiceLine.new
    prepare_form_data
  end

  def create 
    @bsl = BusinessServiceLine.new(bsl_params)
    authorize! :create, @bsl
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

  def show
    @bsl = BusinessServiceLine
            .includes(:sla, :resilience_tickets, steps: [supplier_steps: [supplier: [:sla, :cloud_hosting_provider, :fourth_party_suppliers]]])
            .find(@bsl.id)
    @open_resilience   = @bsl.resilience_tickets.order(:rgid).open
    @onhold_resilience = @bsl.resilience_tickets.order(:rgid).onhold
    @close_resilience  = @bsl.resilience_tickets.order(:rgid).close
  end

  def destroy 
    if @bsl.destroy
      redirect_to organisation_administration_portal_index_path, notice: 'Business Service Line has been deleted successfully.'
    else
      redirect_to organisation_administration_portal_index_path, alert: @bsl.errors.full_messages.first
    end
  end

  def critical_important_suppliers
    @critical_ss  = @bsl.critical_supplier_steps
    @important_ss = @bsl.important_supplier_steps
  end

  def compound_resilience
    if params.dig('supplier_type') == SupplierStep.importance_levels[:critical].to_s
      @service_level_agreement = Supplier.joins(:sla, supplier_steps: [step: [:business_service_line]]).where(business_service_lines: { id: @bsl.id }).where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] }).where.not(slas:{"service_level_agreement": nil})
      @type = 'critical steps'
    elsif params.dig('supplier_type') == SupplierStep.importance_levels[:important].to_s
      @service_level_agreement =  Supplier.joins(:sla, supplier_steps: [step: [:business_service_line]]).where(business_service_lines: { id: @bsl.id }).where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] }).where.not(slas:{"service_level_agreement": nil})
      @type = 'important steps'
    end
  end

  def cloud_service_provider
    @data = Bsl::ChpSupplierService.call(params)
  end

  def bsl_critical_important_supplier
    @data = Bsl::BslCriticalImportantSupplierService.call(params)
  end

  def find_chp_data
    @data = Bsl::ChpSupplierService.call(params[:args])
  end

  def find_compound_resilience_data
    @bsl = BusinessServiceLine.find(params[:args][:bsl])
    if params[:args][:supplier_type] == SupplierStep.importance_levels[:critical].to_s
      @service_level_agreement = Supplier.joins(:sla, supplier_steps: [step: [:business_service_line]]).where(business_service_lines: { id: params[:args][:bsl] }).where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] }).where.not(slas:{"#{params[:args][:sla_name]}": nil})
    elsif params[:args][:supplier_type] == SupplierStep.importance_levels[:important].to_s
      @service_level_agreement = Supplier.joins(:sla, supplier_steps: [step: [:business_service_line]]).where(business_service_lines: { id: params[:args][:bsl] }).where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] }).where.not(slas:{"#{params[:args][:sla_name]}": nil})
    end
  end

  private

  def load_bsl
    @bsl =  if  params[:action] == 'find_chp_data'
              BusinessServiceLine.find_by_id(params[:args][:bsl])
            else
              BusinessServiceLine.where(unit_id: managing_nodes).find(params[:id])
            end
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
        name: "#{RiskAppetite.kind_display_name[k]} - Risk Appetite Rules Engine",
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
          .permit(:unit_id, :name, :description, :tier, :cost_centre_id, :currency_id, :data_classification,
            product_ids: [], channel_ids: [],
            material_risk_taker_attributes: %i[id name title email],
            sla_attributes: %i[id service_level_agreement service_level_objective recovery_point_objective recovery_time_objective transactions_per_second response_time severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration support_hours support_hours_other],
            steps_attributes: [:id, :name, :description, :number, :_destroy, supplier_steps_attributes: %i[id supplier_id party_type importance_level]],
            risk_appetites_attributes: [:id, :name, :amount, :label, :kind, :_destroy, risk_appetite_justifications_attributes: %i[user_id justification]]
          ).merge(unit_id: institution_unit.id)
  end
end
