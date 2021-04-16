class Admin::ProductsController < Admin::BaseController
  before_action :load_product, only: %i[edit update show destroy]

  def index
    @products = Product.order(id: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: 'Product has been created successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product has been updated successfully!'
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

    redirect_to admin_products_path
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :active)
  end
end
