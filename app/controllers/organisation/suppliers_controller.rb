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

  private

  def supplier_params
    params.require(:supplier).permit(:name, :party_type, :contracting_terms, :contracting_terms_other, :status, :start_date, :end_date, :cloud_hosting_provider_id,
                      sla_attributes: %i[id service_level_agreement service_level_objective recovery_time_objective recovery_point_objective severity1 severity2 severity3 severity4 severity1_restoration severity2_restoration severity3_restoration severity4_restoration support_hours support_hours_other],
                      key_contacts_ids: [],
                      supplier_social_accounts_attributes: %i[id social_account_id link],
                      relationship_owner_attributes: %i[name email id]
                    ).merge(unit_id: params[:supplier][:country_unit])
  end

  def load_supplier
    @supplier = Supplier.where(unit_id: managing_nodes).find(params[:id])
  end

  def prepare_form_data
    @key_contacts            = organisational_unit.key_contacts
    @cloud_hosting_providers = CloudHostingProvider.all

    @supplier.build_relationship_owner           if @supplier.relationship_owner.blank?
    @supplier.build_sla                          if @supplier.sla.blank?

    SocialAccount.all.each do |social_account|
      # FIX: N + 1
      @supplier.supplier_social_accounts.build(social_account: social_account) if @supplier.supplier_social_accounts.where(social_account: social_account).blank?
    end
  end
end
