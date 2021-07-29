class Graphs::SupplierConformanceImpactToleranceService < Graphs::BaseService
  COLORS   = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :supplier

  def call
    @supplier = Supplier.find(args.dig('supplier'))
    data[:overall]   = overall

    data
  end

  private

  def overall
    datum = {}
    bsls = BusinessServiceLine.joins(steps: [supplier_steps: [:supplier]])
                              .where(suppliers: {id: supplier.id})
                              .includes(:sla)

    total = bsls.count * 120
    total_sum = 0
    bsls.each do |bsl|
      bsl.sla.attributes.each do |sla_attributes|
        total_sum = total_sum + sla_attributes.second if Sla::SLA_ATTR.include?(sla_attributes.first) && sla_attributes.second.present?       
      end
    end

    datum[:total] = 0
    datum[:graph] = []

    datum[:graph] << {
      name:  'Conformance with impact tolerance',
      y:      0,
      color: COLORS[0],
      count: 0
    }

    datum
  end
end
