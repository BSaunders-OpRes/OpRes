class Graphs::TiersServiceProviderBreakdownService < Graphs::BaseService
  # Service provider breakdown on the basis of tiers.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :bsl_ids
  def call
    @bsl_ids = args.dig("bsl_ids")
    data[:overall_service_provider] = overall
    data
  end

  def overall
    datum = {}
    chp_suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                            .where(business_service_lines: { id: bsl_ids })
                            .group_by { |s| s.cloud_hosting_provider }

    datum[:total] = chp_suppliers.values.flatten.size
    datum[:graph] = []

    CloudHostingProvider.all.each_with_index do |chp, index|
      suppliers = chp_suppliers[chp] || []
      datum[:graph] << {
        name:  chp.short_name,
        y:     datum[:total].zero? ? 0 : ((suppliers.size / datum[:total].to_f) * 100).round(2),
        color: COLORS[index],
        value: suppliers.size,
        logo:  chp.logo
      }
    end
    datum
  end
end

