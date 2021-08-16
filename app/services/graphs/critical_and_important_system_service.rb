class Graphs::CriticalAndImportantSystemService < Graphs::BaseService
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
    critical_supplier_step  = suppliers.collect{|e| e.critical_supplier_steps.count}
    important_supplier_step = suppliers.collect{|e| e.important_supplier_steps.count}

    datum[:suppliers] = suppliers
    datum[:total]    = critical_supplier_step.sum + important_supplier_step.sum
    datum[:graph]    = []

    datum[:graph] << {
      name:  'Critical',
      y:     datum[:total].zero? ? 0 : ((critical_supplier_step.sum / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: critical_supplier_step.sum
    }

    datum[:graph] << {
      name:  'Important',
      y:     datum[:total].zero? ? 0 : ((important_supplier_step.sum / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: important_supplier_step.sum
    }
    datum
  end

  def managing_nodes
    current_user.managing_units.map(&:inclusive_children).flatten.map(&:id)
  end
end
