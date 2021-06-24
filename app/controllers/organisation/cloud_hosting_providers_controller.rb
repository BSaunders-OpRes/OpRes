class Organisation::CloudHostingProvidersController < Organisation::BaseController
  def load_chp_regions_and_services
    cloud_hosting_provider  = CloudHostingProvider.find(params[:cloud_hosting_provider_id])
    @cloud_hosting_provider_regions  = cloud_hosting_provider.cloud_hosting_provider_regions
    @cloud_hosting_provider_services = cloud_hosting_provider.cloud_hosting_provider_services
    @supplier                        = Supplier.find(params[:supplier_id]) if params[:supplier_id].present? 
  end
end
