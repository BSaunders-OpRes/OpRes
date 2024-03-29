class Admin::ProductsController < Admin::BaseController
  before_action :load_product,   only: %i[edit update show destroy]
  before_action :load_form_data, only: %i[new create edit update]

  def index
    @products = PreProduct.order(id: :desc)
  end

  def new
    @product = PreProduct.new
  end

  def create
    @product = PreProduct.new(product_params)

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
    @product = PreProduct.find(params[:id])
  end

  def load_form_data
    @channels = PreChannel.all
  end

  def product_params
    params.require(:pre_product).permit(:name, :description, pre_channel_ids: [])
  end
end
