class Graphs::SystemSupplierResilienceIndicatorService < Graphs::BaseService
  # System Supplier resilience indicator.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :supplier

  def call
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}
    ptype_suppliers = Supplier.joins(:supplier_steps)
                              .select("suppliers.*, supplier_steps.party_type as supplier_party_type")
                              .group("suppliers.id, suppliers.*, supplier_party_type")
                              .group_by(&:supplier_party_type)

    datum[:total]         = ptype_suppliers.values.flatten.size
    datum[:total_match]   = 0
    datum[:total_meet]    = 0
    datum[:total_exceed]  = 0


    ptype_suppliers.each do |key, suppliers|
      datum["#{SupplierStep.party_types.key(key).underscore}"] = {}
      total = 0
      total_sum = 0
      @match_tolerance  =  0
      @meet_tolerance   =  0
      @exceed_tolerance =  0

      suppliers.each do |supplier|
        bsls = BusinessServiceLine.joins(steps: [supplier_steps: [:supplier]])
                                  .where(suppliers: {id: supplier.id})
                                  .includes(:sla)

        total = total + bsls.count * 120

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
      end

      datum["#{SupplierStep.party_types.key(key).underscore}"][:total]     = @match_tolerance + @meet_tolerance + @exceed_tolerance
      datum[:total_exceed]  += @exceed_tolerance
      datum[:total_match]   += @match_tolerance
      datum[:total_meet]    += @meet_tolerance
      #datum["#{SupplierStep.party_types.key(key).underscore}"][:total_bsl] = bsls.size
      datum["#{SupplierStep.party_types.key(key).underscore}"][:graph]     = []

      datum["#{SupplierStep.party_types.key(key).underscore}"][:graph] << {
        name:  'Match Tolerance',
        y:     datum["#{SupplierStep.party_types.key(key).underscore}"][:total].zero? ? 0 : ((@match_tolerance / datum["#{SupplierStep.party_types.key(key).underscore}"][:total].to_f) * 100).round(2),
        color: COLORS[0],
        count: @match_tolerance
      }

      datum["#{SupplierStep.party_types.key(key).underscore}"][:graph] << {
        name:  'Meet Tolerance',
        y:     datum["#{SupplierStep.party_types.key(key).underscore}"][:total].zero? ? 0 : ((@meet_tolerance / datum["#{SupplierStep.party_types.key(key).underscore}"][:total].to_f) * 100).round(2),
        color: COLORS[1],
        count: @meet_tolerance
      }

      datum["#{SupplierStep.party_types.key(key).underscore}"][:graph] << {
        name:  'Exceed Tolerance',
        y:     datum["#{SupplierStep.party_types.key(key).underscore}"][:total].zero? ? 0 : ((@exceed_tolerance / datum["#{SupplierStep.party_types.key(key).underscore}"][:total].to_f) * 100).round(2),
        color: COLORS[2],
        count: @exceed_tolerance
      }
    end
    datum
  end
end
