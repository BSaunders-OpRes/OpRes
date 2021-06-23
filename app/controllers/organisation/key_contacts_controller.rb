class Organisation::KeyContactsController < Organisation::BaseController
  before_action :load_key_contact, only: %i[edit show update destroy]

  def index
    @key_contacts = organisational_unit.key_contacts
  end

  def new
    @key_contact = organisational_unit.key_contacts.new

    respond_to do |format|
      format.html {}
      format.js   {}
    end
  end

  def create
    @key_contact = organisational_unit.key_contacts.new(key_contact_params)

     respond_to do |format|
      if @key_contact.save
        format.html { redirect_to organisation_key_contacts_path, notice: 'key Contact has been created successfully.' }
        format.js   {}
      else
        format.html { render :new }
        format.js   {}
      end
    end
  end

  def edit; end

  def update
    if @key_contact.update(key_contact_params)
      redirect_to organisation_key_contacts_path, notice: 'key Contact has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @key_contact.destroy
      flash[:notice] = 'key contact has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy key contact at the moment!'
    end

    redirect_to organisation_key_contacts_path
  end

  private

  def key_contact_params
    params.require(:key_contact).permit(:name, :email, :job_title)
  end

  def load_key_contact
    @key_contact = organisational_unit.key_contacts.find(params[:id])
  end
end
