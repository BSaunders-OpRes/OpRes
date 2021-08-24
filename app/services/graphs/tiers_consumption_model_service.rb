class Graphs::TiersConsumptionModelService < Graphs::BaseService
  # consumption models on the basis of tiers.
  include Organisation::SuppliersHelper

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :bsl_ids
  def call
    @bsl_ids = args.dig("bsl_ids")
    data[:overall] = overall
    data
  end

  def overall
    datum = {}
    chp_suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                            .where(business_service_lines: { id: bsl_ids })
                            .group_by(&:consumption_model)

    datum[:total] = chp_suppliers.values.flatten.size
    datum[:graph] = []

    Supplier.consumption_models.keys&.each_with_index do  |cm, index|
      suppliers = chp_suppliers[cm] || []
      datum[:graph] << {
        name:  titleize_last_alpha(cm.capitalize),
        y:     datum[:total].zero? ? 0 : ((suppliers.size / datum[:total].to_f) * 100).round(2),
        color: COLORS[index],
        value: suppliers.size,
      }
    end
    datum
  end
end

