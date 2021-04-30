class Organisation::ProductsController < Organisation::BaseController
  before_action :authenticate_org_admin
  before_action :load_product, only: %i[edit update show destroy]

  def index
    @products = organisational_unit.products.order(id: :desc)
  end

  def new
    @product = organisational_unit.products.new
  end

  def create
    @product = organisational_unit.products.new(product_params)

    if @product.save
      redirect_to organisation_products_path, notice: 'Product has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to organisation_products_path, notice: 'Product has been updated successfully!'
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @product.destroy
      flash[:notice] = 'Product has been destroyed successfully!'
    else
      flash[:alert] = 'Error! unable to destroy product at the moment!'
    end

    redirect_to organisation_products_path
  end

  private

  def load_product
    @product = organisational_unit.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description)
  end
end
