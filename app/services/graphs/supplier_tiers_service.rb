class Graphs::SupplierTiersService < Graphs::BaseService
  # Supplier breakdown for important and critical suppliers by tiers.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]
  attr_reader :supplier_ids

  def call
    @supplier_ids  = args['supplier']
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}

    important_suppliers =  Supplier.joins(:supplier_steps)
                                   .where(id: supplier_ids)
                                   .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] })

    critical_suppliers  =  Supplier.joins(:supplier_steps)
                                   .where(id: supplier_ids)
                                   .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] })


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
