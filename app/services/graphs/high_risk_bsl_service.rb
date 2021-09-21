class Graphs::HighRiskBslService < Graphs::BaseService
  # High risk business service line.

 COLORS   = %w[#f5f5f5 #6BEAB3 #367C5C #CDFAF1 #05b368]

  def call
    data[:overall]   = overall
    data
  end

  private

  def overall
    datum = []

    nodes     = filter_data
    bsls      = BusinessServiceLine.where(unit_id: nodes)

    bsls&.each do |bsl|
      @match_tolerance  =  0
      @meet_tolerance   =  0
      @exceed_tolerance =  0

      @exceed_firm_hosted  = 0
      @exceed_3rd_party    = 0
      @exceed_4th_party    = 0
      bsl.supplier_steps

      party_type_suppliers = bsl.supplier_steps.group_by(&:party_type)
      party_type_suppliers.each do |party_type, supplier_steps|

        supplier_steps.each do |supplier_step|
          bsl.risk_appetites.each do |risk_appetite|
          bsl_sla_val       = bsl.sla[risk_appetite.kind]
          supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
          risk_appetite_val = risk_appetite&.amount
            if bsl_sla_val && supplier_sla_val && risk_appetite_val
              if risk_appetite.percentage_amount?
                result = find_score_and_status_for_percentage(bsl_sla_val,  supplier_sla_val, risk_appetite.amount)
                self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
                if result[1] == 'exceed'
                  self.instance_variable_set("@#{result[1]}_#{party_type.underscore}".to_sym, eval("@#{result[1]}_#{party_type.underscore}")+1)
                end
              else
                result = find_score_and_status_for_time(bsl_sla_val,  supplier_sla_val, risk_appetite.amount)
                self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
                if result[1] == 'exceed'
                  self.instance_variable_set("@#{result[1]}_#{party_type.underscore}".to_sym, eval("@#{result[1]}_#{party_type.underscore}")+1)
                end
              end
            end
          end
        end
      end
      datum << {'bsl_name': bsl.name, 'total_resilience_gap': @exceed_tolerance, 'exceed_firm_hosted': @exceed_firm_hosted, 'exceed_3rd_party': @exceed_3rd_party, 'exceed_4th_party': @exceed_4th_party  }
    end
    datum = datum.sort_by{|hsh| -hsh[:total_resilience_gap]}

    datum
  end
end
