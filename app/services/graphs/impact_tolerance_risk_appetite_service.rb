class Graphs::ImpactToleranceRiskAppetiteService < Graphs::BaseService

  def call
    data[:overall] = overall

    data
  end

  private

  def overall
    risk_data   = {}
    nodes       = filter_data

    suppliers     = Supplier.includes(:sla, supplier_steps: [step: [:business_service_line]])
                            .where(unit_id: nodes)
                            .references(:business_service_line, :supplier_steps)
    total_bsls    = BusinessServiceLine.includes(:sla, :risk_appetites, steps: [supplier_steps: [:supplier]])
                                       .where(suppliers: {id: suppliers.pluck(:id)})
                                       .references(:suppliers)
    grouped_bsls  = total_bsls.group_by(&:tier)

    risk_data[:total_exceeds] = 0
    grouped_bsls.each do |tier, tier_bsls|
      risk_data["#{tier}"] = {}

      @critical_match_tolerance     =  0
      @critical_meet_tolerance      =  0
      @critical_exceed_tolerance    =  0
      @important_match_tolerance    =  0
      @important_meet_tolerance     =  0
      @important_exceed_tolerance   =  0
      tbs                           = suppliers.where("business_service_lines.id IN (?)", tier_bsls.pluck(:id))

      tbs.each do |supplier|
        supplier_bsls = total_bsls.where(suppliers: { id: supplier.id })
        supplier_bsls.each do |bsl|
          bsl.risk_appetites.each do |risk_appetite|
            bsl_sla_val       = bsl.sla[risk_appetite.kind]
            supplier_sla_val  = supplier.sla[risk_appetite.kind]
            risk_appetite_val = risk_appetite&.amount
            if bsl_sla_val && supplier_sla_val && risk_appetite_val
              if risk_appetite.percentage_amount?
                result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
                if supplier.supplier_steps.critical.count.positive?
                  self.instance_variable_set("@critical_#{result[1]}_tolerance".to_sym, eval("@critical_#{result[1]}_tolerance")+1)
                end
                if supplier.supplier_steps.important.count.positive?
                  self.instance_variable_set("@important_#{result[1]}_tolerance".to_sym, eval("@important_#{result[1]}_tolerance")+1)
                end
              else
                result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
                 if supplier.supplier_steps.critical.count.positive?
                  self.instance_variable_set("@critical_#{result[1]}_tolerance".to_sym, eval("@critical_#{result[1]}_tolerance")+1)
                end
                if supplier.supplier_steps.important.count.positive?
                  self.instance_variable_set("@important_#{result[1]}_tolerance".to_sym, eval("@important_#{result[1]}_tolerance")+1)
                end
              end
            end
          end
        end
      end
      risk_data["#{tier}"][:critical_match_tolerance]   = @critical_match_tolerance
      risk_data["#{tier}"][:critical_meet_tolerance]    = @critical_meet_tolerance
      risk_data["#{tier}"][:critical_exceed_tolerance]  = @critical_exceed_tolerance
      risk_data["#{tier}"][:important_match_tolerance]  = @important_match_tolerance
      risk_data["#{tier}"][:important_meet_tolerance]   = @important_meet_tolerance
      risk_data["#{tier}"][:important_exceed_tolerance] = @important_exceed_tolerance
      risk_data["#{tier}"][:total_important] = @important_match_tolerance + @important_meet_tolerance + @important_exceed_tolerance
      risk_data["#{tier}"][:total_critical] = @critical_match_tolerance + @critical_meet_tolerance + @critical_exceed_tolerance

      risk_data[:total_exceeds] += (@important_exceed_tolerance + @critical_exceed_tolerance)
    end
    risk_data
  end
end