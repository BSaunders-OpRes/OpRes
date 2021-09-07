class Graphs::SupplierCriticalImportantBslService < Graphs::BaseService
  # Critical & important breakdown of suppliers selected on BSL steps.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :supplier

  def call
    @supplier      = Supplier.find(args['supplier'])
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}

    critical_supplier_step  = supplier.critical_supplier_steps
    important_supplier_step = supplier.important_supplier_steps

    datum[:supplier] = supplier
    datum[:total]    = critical_supplier_step.size + important_supplier_step.size
    datum[:graph]    = []

    datum[:graph] << {
      name:  'Critical Business Services',
      y:     datum[:total].zero? ? 0 : ((critical_supplier_step.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: critical_supplier_step.size
    }

    datum[:graph] << {
      name:  'Important Business Services',
      y:     datum[:total].zero? ? 0 : ((important_supplier_step.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: important_supplier_step.count
    }

    datum
  end
end
