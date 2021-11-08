class Graphs::SupplierConformanceImpactToleranceService < Graphs::BaseService
  # Supplier Conformance Impact Tolerance.

  COLORS   = %w[#f5f5f5 #6BEAB3 #E39A2B #E4412E #05b368]
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
      bsl.excluded_risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
        if bsl_sla_val && supplier_sla_val && risk_appetite_val
          if risk_appetite.percentage_amount?
            result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
            self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
            total_sum = total_sum + result[0]&.to_i
          else
            result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
            self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
            total_sum = total_sum + result[0]&.to_i
          end
        end
      end
    end
    datum[:total] = 100
    datum[:exceed_tolerance] = @exceed_tolerance
    datum[:graph] = []

    datum[:graph] << [
      { name:  'Conformance with impact tolerance' },
      { count: total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2) },
      {
        y: total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2),
        color: COLORS[1]

      },
      {
      y: datum[:total] - (total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2)),
      color: COLORS[0]
      }
    ]
    datum
  end
end
