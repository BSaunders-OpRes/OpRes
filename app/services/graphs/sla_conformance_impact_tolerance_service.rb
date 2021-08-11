class Graphs::SlaConformanceImpactToleranceService < Graphs::BaseService
  # Supplier Conformance Impact Tolerance.

  COLORS   = %w[#f5f5f5 #6BEAB3 #367C5C #CDFAF1 #05b368]
  attr_reader :supplier, :bsl_ids, :sla_attr

  def call
    @supplier        = Supplier.find(args.dig('supplier'))
    @bsl_ids         = args.dig('bsl')
    @sla_attr        = args.dig('sla_attr')
    data[:overall]   = overall
    data
  end

  private

  def overall
    datum = {}
    bsls = args.dig('bsl').present? &&  args.dig('bsl') == '0' ? [] : BusinessServiceLine.includes(:sla).where(business_service_lines: {id: bsl_ids})

    total = bsls.count * 120
    total_sum = 0

    bsls.each do |bsl|

      bsl_sla_val       = bsl.sla[sla_attr]
      supplier_sla_val  = supplier.sla[sla_attr]
      risk_appetite     = bsl.risk_appetites.where(kind: sla_attr)
      risk_appetite_val = risk_appetite.first&.amount

      if bsl_sla_val && supplier_sla_val && risk_appetite_val
        if risk_appetite.first.percentage_amount?
          total_sum = total_sum + find_score_and_status_for_percentage(bsl.sla[risk_appetite.first.kind],  supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)[0]&.to_i
        else
          total_sum = total_sum + find_score_and_status_for_time(bsl.sla[risk_appetite.first.kind],  supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)[0]&.to_i
        end
      end
    end
    datum[:total] = 100
    datum[:graph] = []

    datum[:graph] << [
      { name:  'Conformance with impact tolerance' },
      { count: total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2) },
      {
        y: total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2),
        color: COLORS[1]

      },
      {
      y: datum[:total],
      color: COLORS[0]
      }
    ]
    datum
  end
end
