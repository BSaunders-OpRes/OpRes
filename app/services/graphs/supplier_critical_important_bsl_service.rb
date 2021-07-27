class Graphs::SupplierCriticalImportantBslService < ApplicationService
  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def initialize(args)
    @supplier = Supplier.find(args['supplier'])
    @data     = {}
  end

  attr_reader :supplier, :data

  def call
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
      name:  'Critical',
      y:     datum[:total].zero? ? 0 : ((critical_supplier_step.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: critical_supplier_step.size
    }

    datum[:graph] << {
      name:  'Important',
      y:     datum[:total].zero? ? 0 : ((important_supplier_step.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: important_supplier_step.count
    }

    datum
  end
end
