class Graphs::ImpactToleranceBslsService < Graphs::BaseService
  # Find Impact Tolerances of given bsls.

  attr_reader :bsl_ids

  def call
    @bsl_ids = args.dig('bsl')
    find_impact_tolerances
  end

  private

  def find_impact_tolerances
    datum = []

    bsls = BusinessServiceLine.where(id: bsl_ids)

    bsls&.each do |bsl|
      @exceed_tolerance =  0
      @meet_tolerance   =  0
      @match_tolerance  =  0

      bsl&.supplier_steps&.each do |supplier_step|
        bsl.excluded_risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
          if bsl_sla_val && supplier_sla_val && risk_appetite_val
            if risk_appetite.percentage_amount?
              result = find_score_and_status_for_percentage(bsl_sla_val,  supplier_sla_val, risk_appetite.amount)
              self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
            else
              result = find_score_and_status_for_time(bsl_sla_val,  supplier_sla_val, risk_appetite.amount)
              self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
            end
          end
        end
      end
      datum << {'bsl_id': bsl.id, 'bsl_name': bsl.name, 'exceed': @exceed_tolerance, 'meet': @meet_tolerance, 'match': @match_tolerance  }
    end
    datum
  end
end
