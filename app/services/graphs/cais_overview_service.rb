class  Graphs::CaisOverviewService < Graphs::BaseService
  # Critical & important breakdown of suppliers selected on BSL steps.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :suppliers, :data

  def call
    @suppliers      = Supplier.where(unit_id: managing_nodes)
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
