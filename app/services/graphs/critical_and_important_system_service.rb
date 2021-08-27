class Graphs::CriticalAndImportantSystemService < Graphs::BaseService
  # Critical & important breakdown of suppliers selected on BSL steps.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]
  TOLERANCES = %w[match meet exceed]

  attr_reader :suppliers, :data

  def call
    @suppliers      = Supplier.where(unit_id: managing_nodes)
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}  
    critical_supplier_step  = suppliers.collect{|e| e.critical_supplier_steps.count}
    important_supplier_step = suppliers.collect{|e| e.important_supplier_steps.count}

    critical_suppliers  = suppliers.collect{|e| e.critical_supplier_steps }
    important_suppliers = suppliers.collect{|e| e.important_supplier_steps }
    critical_bsls = Step.where(id: critical_suppliers.flatten.pluck(:step_id)).pluck(:business_service_line_id)
    important_bsls = Step.where(id: important_suppliers.flatten.pluck(:step_id)).pluck(:business_service_line_id)
    set_instance_variables(critical_bsls)
    datum[:c_meet] = @meet_tolerance
    datum[:c_exceed] = @exceed_tolerance
    datum[:c_match]  = @match_tolerance
    datum[:suppliers] = suppliers
    datum[:total]    = critical_supplier_step.sum + important_supplier_step.sum
    datum[:c_graph]    = []
    datum[:i_graph]    = []

    TOLERANCES.each_with_index do |t, index|
      datum[:c_graph] << {
        name:  t,
        type: 'Critical',
        y:     datum[:total]&.zero? ? 0 : ((eval("@#{t}_tolerance") / @meet_tolerance + @match_tolerance + exceed_tolerance) * 100).round(2),
        color: COLORS[index],
        count: critical_supplier_step.sum
      }
    end

    set_instance_variables(important_bsls)
    datum[:i_meet] = @meet_tolerance
    datum[:i_exceed] = @exceed_tolerance
    datum[:i_match]  = @match_tolerance

    TOLERANCES.each_with_index do |t, index|
      datum[:i_graph] << {
        name:  t,
        type: 'Important',
        y:     datum[:total]&.zero? ? 0 : ((eval("@#{t}_tolerance") / @meet_tolerance + @match_tolerance + exceed_tolerance) * 100).round(2),
        color: COLORS[index],
        count: important_supplier_step.sum
      }
    end
    datum
  end

  def set_instance_variables(bsls_ids)    
    @match_tolerance  = 0
    @meet_tolerance   = 0
    @exceed_tolerance = 0
    return nil if bsls_ids.blank?

    bsls = BusinessServiceLine.where(id: bsls_ids)
    bsls&.each do |bsl|
      risk_appetite     = bsl.risk_appetites.first
      risk_appetite_val = risk_appetite.amount
      if risk_appetite_val.present? && bsl.sla[risk_appetite.kind].present? && bsl.supplier_steps.first.supplier.sla[risk_appetite.kind]
        if risk_appetite.percentage_amount? 
          result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind], bsl.supplier_steps.first.supplier.sla[risk_appetite.kind], risk_appetite.amount)
          self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
        else
          result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  bsl.supplier_steps.first.supplier.sla[risk_appetite.kind], risk_appetite.amount)
          self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
        end
      end
    end
  end

  def managing_nodes
    current_user.managing_units.map(&:inclusive_children).flatten.map(&:id)
  end
end
