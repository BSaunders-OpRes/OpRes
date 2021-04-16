class Admin::InstitutionsController < Admin::BaseController
  before_action :load_institution, only: %i[edit update show destroy]
  before_action :load_form_data,   only: %i[new create edit update]

  def index
    @institutions = Institution.order(id: :desc)
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)

    if @institution.save
      redirect_to admin_institutions_path, notice: 'Institution has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @institution.update(institution_params)
      redirect_to admin_institutions_path, notice: 'Institution has been updated successfully!'
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

    redirect_to admin_institutions_path
  end

  private

  def load_institution
    @institution = Institution.find(params[:id])
  end

  def load_form_data
    @products = Product.all
  end

  def institution_params
    params.require(:institution).permit(:name, :description, :active, product_ids: [])
  end
end
