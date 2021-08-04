class Graphs::SystemSupplierResilienceIndicatorService < Graphs::BaseService
  # System Supplier resilience indicator.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :supplier

  def call
    # @supplier      = Supplier.find(args['supplier'])
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}

    # third_party_suppliers  = supplier.third_party_supplier_steps
    # fourth_party_suppliers = supplier.fourth_party_supplier_steps

    datum[:total] = 100
    datum[:graph] = []

    datum[:graph] << {
      name:  'Third',
      y:     0,
      color: COLORS[0],
      count: 0
    }

    datum[:graph] << {
      name:  'Fourth',
      y:      0,
      color: COLORS[1],
      count: 0
    }

    datum
  end
end
