class  Graphs::CaisOverviewService < Graphs::BaseService
  # Critical & important breakdown of suppliers selected on BSL steps.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :suppliers, :data

  def initialize(args)
    @args                = args
    @current_user        = args.dig('current_user')
    @importance_level    = args.dig('importance_level')
    @regions             = args.dig('regions')
    @organisational_unit = args.dig('organisational_unit')

    @data = {}
  end

  def call
    if @importance_level.present? || @regions.present?
      if @regions.present?
        regional_ids = Unit.where(id: managing_nodes).where(type:"Units::Regional").where(name: @regions).ids
        @suppliers = Supplier.where(unit_id: regional_ids || managing_nodes)
      else
        @suppliers = Supplier.where(unit_id: regional_ids || managing_nodes).joins(:supplier_steps).where(supplier_steps: { importance_level: @importance_level })
      end
    else
      @suppliers = Supplier.where(unit_id: managing_nodes)
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
