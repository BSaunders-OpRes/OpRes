class Organisation::SuppliersController < Organisation::BaseController
  before_action :load_supplier, only: %i[edit update show destroy]

  def new
    @supplier = Supplier.new
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
        format.html { render :new }
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

  def show; end

  def destroy; end

  def all_suppliers
    @suppliers = Supplier.where(unit_id: managing_nodes)

    respond_to do |format|
      format.json { render json: @suppliers }
    end
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
    %i[id service_level_agreement service_level_objective recovery_time_objective recovery_point_objective severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration support_hours support_hours_other]
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
