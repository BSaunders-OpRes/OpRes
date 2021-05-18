class Organisation::SupplierContactsController < Organisation::BaseController
  before_action :load_supplier_contact, only: %i[edit show update destroy]

  def index
    @supplier_contacts = organisational_unit.supplier_contacts
  end

  def new
    @supplier_contact = organisational_unit.supplier_contacts.new
  end

  def create
    @supplier_contact = organisational_unit.supplier_contacts.new(supplier_contact_params)

    if @supplier_contact.save
      redirect_to organisation_supplier_contacts_path, notice: 'Supplier Contact has been created successfully.'
    else
      render :new
    end
  end

  def edit; end


  def update
    if @supplier_contact.update(supplier_contact_params)
      redirect_to organisation_supplier_contacts_path, notice: 'Supplier Contact has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @supplier_contact.destroy
      flash[:notice] = 'supplier contact has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy supplier contact at the moment!'
    end

    redirect_to organisation_supplier_contacts_path
  end

  private

  def supplier_contact_params
    params.require(:supplier_contact).permit(:name, :email)
  end

  def load_supplier_contact
    @supplier_contact = organisational_unit.supplier_contacts.find(params[:id])
  end
end
