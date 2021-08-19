class Graphs::BslSuppliersCriticalImportantService < Graphs::BaseService
  # Critical & important breakdown of suppliers selected on BSL steps.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :bsl

  def call
    @bsl      = BusinessServiceLine.find(args['bsl'])
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}

    critical_suppliers  = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                                  .where(business_service_lines: { id: bsl.id })
                                  .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] })

    important_suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                                  .where(business_service_lines: { id: bsl.id })
                                  .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] })

    datum[:total]    = critical_suppliers.size + important_suppliers.size
    datum[:graph]    = []

    datum[:graph] << {
      name:  'Critical Suppliers',
      y:     datum[:total].zero? ? 0 : ((critical_suppliers.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: critical_suppliers.size
    }

    datum[:graph] << {
      name:  'Important Suppliers',
      y:     datum[:total].zero? ? 0 : ((important_suppliers.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: important_suppliers.size
    }
    datum
  end
end
