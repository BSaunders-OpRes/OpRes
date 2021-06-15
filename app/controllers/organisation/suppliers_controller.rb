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
    params.require(:supplier).permit(:name, :party_type, :contracting_terms, :status,
                      cloud_hosting_provider_attributes: %i[name id],
                      sla_attributes: %i[id service_level_agreement service_level_objective recovery_point_objective severity1_response_time severity2_response_time severity3_response_time severity4_response_time  severity1_restoration_service_time severity2_restoration_service_time severity3_restoration_service_time severity4_restoration_service_time support_hours id],
                      key_contacts_ids: [],
                      relationship_owner_attributes: %i[name id]
                    ).merge(unit_id: params[:supplier][:country_unit])
  end

  def load_supplier
    @supplier = Supplier.where(unit_id: managing_unit.inclusive_children.map(&:id)).find(params[:id])
  end

  def prepare_form_data
    @key_contacts = organisational_unit.key_contacts

    @supplier.build_cloud_hosting_provider if @supplier.cloud_hosting_provider.blank?
    @supplier.build_relationship_owner     if @supplier.relationship_owner.blank?
    @supplier.build_sla                    if @supplier.sla.blank?
  end
end
