class Graphs::BslStepSupplierChpService < ApplicationService
  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def initialize(bsl)
    @bsl  = bsl
    @data = {}
  end

  attr_reader :bsl, :data

  def call
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}

    chp_suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                            .where(business_service_lines: { id: bsl.id })
                            .group_by { |s| s.cloud_hosting_provider }

    datum[:total] = chp_suppliers.values.flatten.size
    datum[:graph] = []

    chp_suppliers.each_with_index do |(chp, suppliers), index|
      datum[:graph] << {
        name:  chp.short_name,
        y:     ((suppliers.size / datum[:total].to_f) * 100).round(2),
        color: COLORS[index],
        value: suppliers.size,
        logo:  chp.logo
      }
    end

    datum
  end
end
