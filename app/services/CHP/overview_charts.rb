class CHP::OverviewCharts < ApplicationService
  def initialize(args)
    @organisational_unit = args.dig(:organisational_unit)
    @data = {}
  end
  
  attr_reader :data, :organisational_unit
  
  def call
    @nodes = organisational_unit.inclusive_children.map(&:id)
    bsls   = BusinessServiceLine.includes(steps: [supplier_steps: [supplier: :cloud_hosting_provider]])
                                .where(unit_id: @nodes)
                                .references(:supplier, :cloud_hosting_provider)

    chp_objs.each do |co|
      data[co.short_name] = {}
      data[co.short_name][:logo] = co.logo
      data[co.short_name][:name] = co.short_name
      chp_model_supplier.each do  |c_model|
        data[co.short_name][c_model] = {}
        cm_bsls = bsls.where("suppliers.consumption_model = ? AND cloud_hosting_providers.short_name = ? ", Supplier.consumption_models[c_model], co.short_name)
        data[co.short_name][c_model][:bsls] = cm_bsls
        cm_bsls.each do |bsl|
          data[co.short_name][c_model][bsl.id] = {}
          b_suppliers = Supplier.joins(supplier_steps: [step: :business_service_line]).where(business_service_lines: { id: bsl.id })
          data[co.short_name][c_model][bsl.id][:suppliers] = b_suppliers
          b_suppliers.each do |supplier|
            data[co.short_name][c_model][bsl.id][supplier.id]  = {}
            data[co.short_name][c_model][bsl.id][supplier.id][:cloud_services] = supplier.cloud_hosting_provider.cloud_hosting_provider_services.where(service_tag: c_model).pluck(:name)
          end
        end
      end
    end
    # data[:chp_obj]   = chp_objs
    # data[:chp_model_supplier] = chp_model_supplier
    # data[:chp_suppliers] = chp_suppliers
    data
  end

  private

  def chp_objs
    @chps = CloudHostingProvider.all
  end

  def chp_model_supplier
    suppliers = Supplier.consumption_models.keys
  end

  def chp_suppliers
    Supplier.where(unit_id: @nodes).group_by{ |e| e.cloud_hosting_provider.short_name }.each_with_object({}) {|(k,v), h| h[k] = v.group_by { |s| s.consumption_model}}
  end
end
