class Organisation::SuppliersController < Organisation::BaseController
  load_and_authorize_resource

  before_action :load_supplier, only: %i[edit update show destroy critical_important_suppliers compound_resilience search_and_filter]

  def new
    @supplier = Supplier.new(params[:supplier_params]&.permit!)
    @selected_services = params[:supplier_params][:cloud_hosting_provider_services_ids] if params[:supplier_params].present?
    prepare_form_data
  end

  def create
    @supplier = Supplier.new(supplier_params)
    respond_to do |format|
      if @supplier.save
        format.json { render json: { resp: @supplier } }
        format.html { redirect_to organisation_administration_portal_index_path, notice: 'Supplier has been created successfully.' }
      else
        prepare_form_data
        format.json { render json: { errors: @supplier.errors.full_messages } }
        format.html { redirect_to new_organisation_supplier_path(supplier_params: supplier_params), alert: @supplier.errors.full_messages }
      end
    end
  end

  def edit
    prepare_form_data
  end

  def update
    if @supplier.update(supplier_params)
      redirect_to organisation_administration_portal_index_path, notice: 'Supplier has been updated successfully.'
    else
      prepare_form_data
      render :edit
    end
  end

  def show
    @chp                    = @supplier.cloud_hosting_provider
    @chp_region             = @supplier.cloud_hosting_provider_region
    @third_party_suppliers  = @supplier.third_party_suppliers.includes(:cloud_hosting_provider)
    @fourth_party_suppliers = @supplier.fourth_party_suppliers.includes(:cloud_hosting_provider)
    @compliance_evidences   = PaginationService.new(@supplier.compliance_evidences, params[:page], params[:filter] || 5).paginate_array
    @chp_services           = @supplier.cloud_hosting_provider_services
  end

  def destroy; end

  def all_suppliers
    @suppliers = Supplier.where(unit_id: managing_nodes)

    respond_to do |format|
      format.json { render json: @suppliers }
    end
  end

  def critical_important_suppliers
    @critical_ss  = @supplier.critical_supplier_steps
    @important_ss = @supplier.important_supplier_steps
  end

  def compound_resilience
    @service_level_agreement = BusinessServiceLine.joins(:sla, steps: [supplier_steps: [:supplier]])
                                                  .where(suppliers: {id: @supplier.id})
                                                  .where.not(slas:{ service_level_agreement: nil})
  end

  def search_and_filter
    @compliance_evidences = PaginationService.new(search_compliance_evidence, params[:page], params[:filter] || 5).paginate_array
  end

  def search_compliance_evidence
    @key = ""
    @key << "name ILIKE :query" if params[:query].present?
    # if params[:sort].present?
    #   if params[:sort] == 'green'
    #     @key << " AND create_at < :date"
    #   elsif params[:sort] == 'amber'
    #     @key << " AND create_at = :date"
    #   else
    #     @key << " AND create_at > :date"
    #   end
    # end
    @supplier.compliance_evidences.where(@key, query: "%#{params[:query]}%")
  end

  def find_compound_resilience_data
    @supplier = Supplier.find(params[:args][:supplier])
    @service_level_agreement = BusinessServiceLine.joins(:sla, steps: [supplier_steps: [:supplier]])
                                                  .where(suppliers: {id: @supplier.id})
                                                  .where.not(slas:{ "#{params[:args][:sla_name]}": nil})
  end

  private

  def supplier_params
    params.require(:supplier)
          .permit(
            :name, :contracting_terms, :contracting_terms_other, :start_date, :end_date, :description, :annual_cost_of_contract,
            :cloud_hosting_provider_description, :consumption_model, :consumption_model_other,
            :cloud_hosting_provider_id, :cloud_hosting_provider_region_id, cloud_hosting_provider_services_ids: [],
            key_contacts_ids: [], relationship_owner_attributes: relationship_owner_attributes,
            social_account_recipients_attributes: social_account_recipients_attributes,
            sla_attributes: sla_attributes,
            third_party_suppliers_attributes: sub_supplier_attributes,
            fourth_party_suppliers_attributes: sub_supplier_attributes
          ).merge(unit_id: params[:supplier][:country_unit])
  end

  def sla_attributes
    %i[id service_level_agreement service_level_objective recovery_time_objective recovery_point_objective transactions_per_second response_time severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration support_hours support_hours_other]
  end

  def relationship_owner_attributes
    %i[name email id]
  end

  def social_account_recipients_attributes
    %i[id social_account_id link]
  end

  def sub_supplier_attributes
    [:id, :name, :cloud_hosting_provider_id, :cloud_hosting_provider_description, :_destroy, sla_attributes: sla_attributes]
  end

  def load_supplier
    @supplier = Supplier.where(unit_id: managing_nodes).find(params[:id])
  end

  def prepare_form_data
    @key_contacts            = organisational_unit.key_contacts
    @cloud_hosting_providers = CloudHostingProvider.all

    @supplier.build_relationship_owner     if @supplier.relationship_owner.blank?
    @supplier.build_sla                    if @supplier.sla.blank?
    @supplier.third_party_suppliers.build  if @supplier.third_party_suppliers.blank?
    @supplier.fourth_party_suppliers.build if @supplier.fourth_party_suppliers.blank?

    SocialAccount.all.each do |social_account|
      # FIX: N + 1
      @supplier.social_account_recipients.build(social_account: social_account) if @supplier.social_account_recipients.where(social_account: social_account).blank?
    end
  end
end
