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
    nodes     = organisational_unit.inclusive_children.map(&:id)
    bsls      = BusinessServiceLine.where(unit_id: nodes)
    @match_firm_hosted_tolerance  =  0
    @match_3rd_party_tolerance    =  0
    @match_4th_party_tolerance    =  0
    @meet_firm_hosted_tolerance   =  0
    @meet_3rd_party_tolerance     =  0
    @meet_4th_party_tolerance     =  0
    @exceed_firm_hosted_tolerance =  0
    @exceed_3rd_party_tolerance   =  0
    @exceed_4th_party_tolerance   =  0

    SupplierStep.party_types.keys.each do |step|
      datum[step.underscore] = {}
      datum[step.underscore][:total] = 0
    end

    bsls&.each do |bsl|
      party_type_suppliers = bsl.supplier_steps.group_by(&:party_type)
      party_type_suppliers.each do |party_type, supplier_steps|
        supplier_steps.each do |supplier_step|
          datum[party_type.underscore][:total] += 1
          bsl.risk_appetites.each do |risk_appetite|
            bsl_sla_val       = bsl.sla[risk_appetite.kind]
            supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
            risk_appetite_val = risk_appetite&.amount
            if bsl_sla_val && supplier_sla_val && risk_appetite_val
              if risk_appetite.percentage_amount?
                result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier_step.supplier.sla[risk_appetite.kind], risk_appetite.amount)
                self.instance_variable_set("@#{result[1]}_#{party_type.underscore}_tolerance".to_sym, eval("@#{result[1]}_#{party_type.underscore}_tolerance")+1)
              else
                result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier_step.supplier.sla[risk_appetite.kind], risk_appetite.amount)
                self.instance_variable_set("@#{result[1]}_#{party_type.underscore}_tolerance".to_sym, eval("@#{result[1]}_#{party_type.underscore}_tolerance")+1)
              end
            end
          end
        end
      end
    end
    total_sum = 0
    total_match = 0
    total_meet = 0
    total_exceed = 0
    SupplierStep.party_types.keys.each do |step|
      total         = eval("@match_#{step.underscore}_tolerance") + eval("@meet_#{step.underscore}_tolerance") + eval("@exceed_#{step.underscore}_tolerance")
      total_sum     += total
      total_match   += eval("@match_#{step.underscore}_tolerance")
      total_meet    += eval("@meet_#{step.underscore}_tolerance")
      total_exceed  += eval("@exceed_#{step.underscore}_tolerance")
      datum[step.underscore][:graph] = []
      datum[step.underscore][:graph] << {
        name:  'Match Tolerance',
        y:     datum[step.underscore][:total].zero? ? 0 : ((eval("@match_#{step.underscore}_tolerance") / total.to_f) * 100).round(2),
        color: COLORS[0],
        count: eval("@match_#{step.underscore}_tolerance")
      }
      datum[step.underscore][:graph] << {
        name:  'Meet Tolerance',
        y:     datum[step.underscore][:total].zero? ? 0 : ((eval("@meet_#{step.underscore}_tolerance") / total.to_f) * 100).round(2),
        color: COLORS[1],
        count: eval("@meet_#{step.underscore}_tolerance")
      }
      datum[step.underscore][:graph] << {
        name:  'Exceed Tolerance',
        y:     datum[step.underscore][:total].zero? ? 0 : ((eval("@exceed_#{step.underscore}_tolerance") / total.to_f) * 100).round(2),
        color: COLORS[2],
        count: eval("@exceed_#{step.underscore}_tolerance")
      }
    end
    datum[:total]         = total_sum
    datum[:total_match]   = total_match
    datum[:total_meet]    = total_meet
    datum[:total_exceed]  = total_exceed
    datum
  end
end
