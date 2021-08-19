class Graphs::SupplierImpactToleranceBreakdownService < Graphs::BaseService
  # Impact tolerance breakdown on the basis of its SLA attributes.

  COLORS   = %w[#6BEAB3 #e49b2e #E4412E]

  attr_reader :supplier_ids, :bsl, :sla_attr

  def call
    @supplier_ids    = args.dig('supplier')
    @bsl             = BusinessServiceLine.find_by_id(args.dig('bsl'))
    @sla_attr        = args.dig('sla_attr')
    data[:overall]   = overall
    data
  end

  private

  def overall
    datum = {}

    suppliers = args.dig('supplier').present? &&  args.dig('supplier') == '0' ? [] : Supplier.includes(:sla).where(suppliers: {id: supplier_ids})

    total = suppliers.count * 120
    total_sum = 0
    @match_tolerance  =  0
    @meet_tolerance   =  0
    @exceed_tolerance =  0

    suppliers.each do |supplier|
      bsl_sla_val       = bsl.sla[sla_attr]
      supplier_sla_val  = supplier.sla[sla_attr]
      risk_appetite     = bsl.risk_appetites.where(kind: sla_attr)
      risk_appetite_val = risk_appetite.first&.amount

      if bsl_sla_val && supplier_sla_val && risk_appetite_val
        if risk_appetite.first.percentage_amount?
          result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.first.kind],  supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)
          self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
        else
          result = find_score_and_status_for_time(bsl.sla[risk_appetite.first.kind],  supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)
          self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
        end
      end
    end
    datum[:total]     = @match_tolerance + @meet_tolerance + @exceed_tolerance
    datum[:total_supplier] = suppliers.size
    datum[:graph]     = []

    datum[:graph] << {
      name:  'Match Impact Tolerance',
      y:     datum[:total].zero? ? 0 : ((@match_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[0],
      count: @match_tolerance
    }

    datum[:graph] << {
      name:  'Meet Impact Tolerance',
      y:     datum[:total].zero? ? 0 : ((@meet_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[1],
      count: @meet_tolerance
    }

    datum[:graph] << {
      name:  'Exceed Impact Tolerance',
      y:     datum[:total].zero? ? 0 : ((@exceed_tolerance / datum[:total].to_f) * 100).round(2),
      color: COLORS[2],
      count: @exceed_tolerance
    }
    datum
  end
end

