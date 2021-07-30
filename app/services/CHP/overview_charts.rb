class CHP::OverviewCharts < ApplicationService
  def initialize(args)
    @organisational_unit = args.dig(:organisational_unit)
    @data = {}
  end
  
  attr_reader :data, :organisational_unit
  
  def call
    @nodes = organisational_unit.inclusive_children.map(&:id)
    data[:chp_obj]   = chp_objs
    data[:chp_model_supplier] = chp_model_supplier
    data[:chp_suppliers] = chp_suppliers

    data
  end

  private

  def chp_objs
   @chps = CloudHostingProvider.all
  end

  def chp_model_supplier
    suppliers = Supplier.consumption_models    
  end

  def chp_suppliers
    suppliers = Supplier.where(unit_id: @nodes).group_by(&:cloud_hosting_provider)
  end
end
