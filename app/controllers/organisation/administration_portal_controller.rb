class Organisation::AdministrationPortalController < Organisation::BaseController
  def index
    @business_service_lines = BusinessServiceLine.where(unit_id: managing_unit.inclusive_children.map(&:id)).order(id: :desc)
    @suppliers              = Supplier.where(unit_id: managing_unit.inclusive_children.map(&:id)).order(id: :desc)
  end
end
