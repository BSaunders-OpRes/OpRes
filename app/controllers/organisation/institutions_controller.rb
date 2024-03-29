class Organisation::InstitutionsController < Organisation::BaseController
  before_action :authenticate_root_user
  before_action :load_institution, only: %i[edit update show destroy]
  before_action :load_form_data,   only: %i[new create edit update]

  def index
    @institutions = organisational_unit.institutions.order(id: :desc)
  end

  def new
    @institution = organisational_unit.institutions.new
  end

  def create
    @institution = organisational_unit.institutions.new(institution_params)

    if @institution.save
      redirect_to organisation_institutions_path, notice: 'Institution has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @institution.update(institution_params)
      redirect_to organisation_institutions_path, notice: 'Institution has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @institution.destroy
      flash[:notice] = 'Institution has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy institution at the moment!'
    end

    redirect_to organisation_institutions_path
  end

  def search_by_name
    @institutions = organisational_unit.institutions.where("name ILIKE (?)", "%#{params[:query]}%").order(id: :desc)
  end

  private

  def load_institution
    @institution = organisational_unit.institutions.find(params[:id])
  end


  def load_form_data
    @products = organisational_unit.products
  end

  def institution_params
    params.require(:institution).permit(:name, :description, product_ids: [])
  end
end
