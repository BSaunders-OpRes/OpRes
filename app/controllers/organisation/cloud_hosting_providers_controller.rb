class Organisation::CloudHostingProvidersController < Organisation::BaseController
  before_action :load_cloud_hosting_provider, only: %i[regions_services]

  def regions_services
    @supplier = Supplier.find_by(id: params[:supplier_id])
  end

  private

  def load_cloud_hosting_provider
    @cloud_hosting_provider = CloudHostingProvider.find_by(id: params[:id])
  end
end
