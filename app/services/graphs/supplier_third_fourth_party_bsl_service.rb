class Graphs::SupplierThirdFourthPartyBslService < ApplicationService
  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def initialize(args)
    @supplier = Supplier.find(args['supplier'])
    @data     = {}
  end

  attr_reader :supplier, :data

  def call
    data[:overall]   = overall

    data
  end

  private

  def overall
    datum = {}

    third_party_suppliers  = supplier.third_party_supplier_steps
    fourth_party_suppliers = supplier.fourth_party_supplier_steps
 
    datum[:total] = third_party_suppliers.size + fourth_party_suppliers.size
    datum[:graph] = []

    datum[:graph] << {
      name:  'Third',
      y:     datum[:total].zero? ? 0 : ((third_party_suppliers.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: third_party_suppliers.size
    }

    datum[:graph] << {
      name:  'Fourth',
      y:     datum[:total].zero? ? 0 : ((fourth_party_suppliers.size / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: fourth_party_suppliers.size
    }

    datum
  end
end
