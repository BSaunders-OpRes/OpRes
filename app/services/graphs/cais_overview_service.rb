class  Graphs::CaisOverviewService < Graphs::BaseService
  # Critical & important breakdown of suppliers selected on BSL steps.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :suppliers, :data

  def initialize(args)
    @args                = args
    @current_user        = args.dig('current_user')
    @importance_level    = args.dig('importance_level')
    @regions             = args.dig('regions')
    @countries           = args.dig('countries')
    @firms               = args.dig('firms')
    @products            = args.dig('products')
    @organisational_unit = args.dig('organisational_unit')

    @data = {}
  end

  def call
    @suppliers = []
    if @regions.present? || @firms.present? || @countries.present? || @products.present?
      regional_unit_ids = Unit.where(id: managing_nodes).where(type:"Units::Regional").where(name: @regions).ids if @regions.present?
      child_units = Unit.where(id: regional_unit_ids)&.map{|e| e.children.ids }&.flatten
      @suppliers << Supplier.where(unit_id: child_units) if Supplier.where(unit_id: child_units).size > 0 
      countries_unit_ids = Unit.where(id: managing_nodes).where(type:"Units::Country").where(name: @countries).ids if @countries.present?
      @suppliers << Supplier.where(unit_id: countries_unit_ids) if Supplier.where(unit_id: countries_unit_ids).size > 0
      firms_units = Unit.where(id: managing_nodes).where(type:"Units::Institution").where(name: @firms) if @firms.present?
      parent_units = firms_units&.map{|e| e.parent.id }&.flatten
      @suppliers << Supplier.where(unit_id: parent_units) if Supplier.where(unit_id: parent_units).size > 0
      ids = @suppliers&.map{|e| e.ids }&.flatten
      if @importance_level.present?
        @suppliers = Supplier.where(id: ids).joins(:supplier_steps).where(supplier_steps: {importance_level: @importance_level})
      else
        @suppliers = Supplier.where(id: ids)
      end
    else
      if @importance_level.present?
        @suppliers = Supplier.where(unit_id: managing_nodes).joins(:supplier_steps).where(supplier_steps: {importance_level: @importance_level})
      else
        @suppliers = Supplier.where(unit_id: managing_nodes)
      end
    end
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {} 
    chp_suppliers  = suppliers.group_by{ |e| e.cloud_hosting_provider.short_name }
    cm_suppliers = suppliers.group_by{ |e| e.consumption_model }

    datum[:suppliers] = suppliers
    datum[:chp_total]    = chp_suppliers.values.flatten.collect{|s| s.supplier_steps.count }.sum
    datum[:cm_total] = cm_suppliers.values.flatten.collect{|s| s.supplier_steps.count }.sum
    datum[:chp_suppliers] = chp_suppliers
    datum[:cm_suppliers] = cm_suppliers
    datum[:chp_graph]    = []
    datum[:cm_graph]    = []

    ["GCP", "AWS", "Private Cloud", "Azure"]&.uniq.each_with_index do |key, index|
        datum[:chp_graph] << {
          name: key,
          y:     chp_suppliers[key].blank? ? 0 : ((chp_suppliers[key]&.collect{|s| s.supplier_steps.count }&.sum || 0 / datum[:chp_total].to_f) * 100).round(2),
          color: COLORS[index],
          count: chp_suppliers[key]&.collect{|s| s.supplier_steps.count }&.sum || 0
        }
    end

    ["saas", "paas", "iaas", "others"].uniq.each_with_index do |key, index|
      datum[:cm_graph] << {
          name: key.humanize,
          y:     cm_suppliers[key].blank? ? 0 : ((cm_suppliers[key]&.collect{|s| s.supplier_steps.count }&.sum || 0 / datum[:chp_total].to_f) * 100).round(2),
          color: COLORS[index],
          count: cm_suppliers[key]&.collect{|s| s.supplier_steps.count }&.sum || 0
      }
    end
    datum
  end

  def managing_nodes
    current_user.managing_units.map(&:inclusive_children).flatten.map(&:id)
  end
end
