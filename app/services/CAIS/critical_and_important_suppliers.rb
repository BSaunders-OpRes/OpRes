class CAIS::CriticalAndImportantSuppliers < ApplicationService
  def initialize(args)
    @organisational_unit = args.dig(:organisational_unit)
    @data = {}
  end
  
  attr_reader :data, :organisational_unit
  
  def call
    @nodes = organisational_unit.inclusive_children.map(&:id)
    data[:consumption_model_suppliers] = consumption_model_suppliers
    data[:chp_suppliers] = chp_suppliers
    data
  end

  private

  def chp_suppliers
    Supplier.where(unit_id: @nodes).group_by{ |e| e.cloud_hosting_provider.short_name }
  end

  def consumption_model_suppliers
    Supplier.where(unit_id: @nodes).group_by{ |e| e.consumption_model }
  end
end
