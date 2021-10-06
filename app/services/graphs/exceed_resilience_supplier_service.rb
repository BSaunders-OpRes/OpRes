class Graphs::ExceedResilienceSupplierService < Graphs::BaseService
  # Exceed resilience supplier.

  attr_reader :bsl_ids

  def call
    @bsl_ids         = args.dig('bsl')
    find_exceed_tolerance_count
  end

  private

  def find_exceed_tolerance_count
    bsls = BusinessServiceLine.where(id: bsl_ids)

    @exceed_tolerance =  0
    bsls&.each do |bsl|

      bsl&.supplier_steps&.each do |supplier_step|
        bsl.excluded_risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
          if bsl_sla_val && supplier_sla_val && risk_appetite_val
            if risk_appetite.percentage_amount?
              result = find_score_and_status_for_percentage(bsl_sla_val,  supplier_sla_val, risk_appetite.amount)
              if result[1] == 'exceed'
                self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
              end
            else
              result = find_score_and_status_for_time(bsl_sla_val,  supplier_sla_val, risk_appetite.amount)
              if result[1] == 'exceed'
                self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
              end
            end
          end
        end
      end
    end
    @exceed_tolerance
  end
end
