class Graphs::BslSupplierConformanceImpactToleranceService < Graphs::BaseService
  # Bsl supplier Conformance Impact Tolerance.

  COLORS     = %w[#6BEAB3 #e49b2e #E4412E #05b368 #f5f5f5]
  COLORS_2   = %w[#6BEAB3 #e49b2e #E4412E]

  attr_reader :bsl, :supplier_ids

  def call
    @bsl           = BusinessServiceLine.find(args.dig('bsl'))
    @supplier_ids  = args.dig('supplier')
    data[:overall] = overall
    data
  end

  private

  def overall
    datum = {}

    suppliers = if args.dig('critical_system') == 'true'
                  Supplier.joins(supplier_steps: [step: [:business_service_line]])
                          .where(business_service_lines: { id: bsl.id })
                          .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] })
                          .includes(:sla)
                elsif args.dig('important_system') == 'true'
                  Supplier.joins(supplier_steps: [step: [:business_service_line]])
                          .where(business_service_lines: { id: bsl.id })
                          .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] })
                          .includes(:sla)
                elsif args.dig('supplier')
                  args.dig('supplier').present? &&  args.dig('supplier') == '0' ? [] : Supplier.includes(:sla).where(suppliers: {id: supplier_ids})
                else
                  Supplier.joins(supplier_steps: [step: [:business_service_line]])
                          .where(business_service_lines: { id: bsl.id })
                          .includes(:sla)
                end

    total = suppliers.count * 120
    total_sum = 0
    @match_tolerance  =  0
    @meet_tolerance   =  0
    @exceed_tolerance =  0

    suppliers.each do |supplier|
      bsl.risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
        if bsl_sla_val && supplier_sla_val && risk_appetite_val
          if risk_appetite.percentage_amount?
            result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
            total_sum = total_sum + result[0]&.to_i
            self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
          else
            result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
            total_sum = total_sum + result[0]&.to_i
            self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
          end
        end
      end
    end

    datum[:total]     = @match_tolerance + @meet_tolerance + @exceed_tolerance
    datum[:total_suppliers] = suppliers.size
    datum[:graph]     = []
    datum[:small_graph] = []

    datum[:graph] << [
      { name:  'Conformance with impact tolerance' },
      { count: total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2) },
      {
        y: total_sum.zero? ? 0 : ((total_sum / total.to_f) * 100).round(2),
        color: COLORS[0]

      },
      {
      y: 100,
      color: COLORS[4]
      }
    ]

    datum[:small_graph] << {
      name:  'Match Tolerance',
      y:     datum[:total].zero? ? 0 : ((@match_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: @match_tolerance
    }

    datum[:small_graph] << {
      name:  'Meet Tolerance',
      y:     datum[:total].zero? ? 0 : ((@meet_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: @meet_tolerance
    }

    datum[:small_graph] << {
      name:  'Exceed Tolerance',
      y:     datum[:total].zero? ? 0 : ((@exceed_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[2],
      count: @exceed_tolerance
    }

    datum
  end
end
