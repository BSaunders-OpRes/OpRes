class Graphs::ConsumptionChpService < Graphs::BaseService
  # CHP breakdown of suppliers.
  include Organisation::SuppliersHelper

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def call
    nodes     = organisational_unit.inclusive_children.map(&:id)
    suppliers = Supplier.where(unit_id: nodes).group_by(&:consumption_model)

    data[:total] = suppliers.values.flatten.size
    data[:graph] = []

    Supplier.consumption_models.each do |obj, number|
      spls = suppliers[obj] || []
      data[:graph] << {
        name:  titleize_last_alpha(obj.capitalize),
        y:     data[:total].zero? ? 0 : ((spls.size / data[:total].to_f) * 100).round(2),
        color: COLORS[number],
        value: spls.size
      }
    end

    data
  end
end
