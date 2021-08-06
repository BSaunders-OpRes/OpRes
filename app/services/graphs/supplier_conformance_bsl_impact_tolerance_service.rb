class Graphs::SupplierConformanceBslImpactToleranceService < Graphs::BaseService
  # Supplier Conformance Business service Impact Tolerance.

  COLORS   = %w[#6BEAB3 #367C5C #CDFAF1 #05b368 #f5f5f5]
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
    @match_tolerance  =  0
    @meet_tolerance   =  0
    @exceed_tolerance =  0

    bsls.each do |bsl|
      bsl.risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
        if bsl_sla_val && supplier_sla_val && risk_appetite_val
          if risk_appetite.percentage_amount?
            result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
            self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
          else
            result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
            self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
          end
        end
      end
    end
    datum[:total]     = @match_tolerance + @meet_tolerance + @exceed_tolerance
    datum[:total_bsl] = bsls.size
    datum[:graph]     = []

    datum[:graph] << {
      name:  'Match Tolerance',
      y:     datum[:total].zero? ? 0 : ((@match_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: @match_tolerance
    }

    datum[:graph] << {
      name:  'Meet Tolerance',
      y:     datum[:total].zero? ? 0 : ((@meet_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: @meet_tolerance
    }

    datum[:graph] << {
      name:  'Exceed Tolerance',
      y:     datum[:total].zero? ? 0 : ((@exceed_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[2],
      count: @exceed_tolerance
    }
    datum
  end
end

