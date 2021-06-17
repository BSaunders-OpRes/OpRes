class Organisation::AdministrationPortalController < Organisation::BaseController
  def index
    managing_nodes
    @business_service_lines = BusinessServiceLine.where(unit_id: @managing_nodes).order(id: :desc)
    @suppliers              = Supplier.where(unit_id: @managing_nodes).order(id: :desc)
  end
end
