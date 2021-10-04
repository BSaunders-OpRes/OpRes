class BreakdownService < Graphs::BaseService
  attr_accessor :sla_attr, :filter, :sla_attributes

  def calculate_breakdown
    @sla_attr       = args.dig(:sla_attr)
    @filter         = args.dig(:filter)
    @sla_attributes = args.dig(:sla_attr).present? ? Sla::SLA_ATTR.select { |sla| sla == @sla_attr } : Sla::SLA_ATTR
    nodes     = filter_data

    breakdown_data = {}
    breakdown_data[:overall_tolerance] = 0
    suppliers = Supplier.includes(:supplier_steps, :sla).where(unit_id: nodes)
                                                        .where("supplier_steps.party_type IN (?)", filter_by_party_type)
                                                        .references(:supplier_steps).uniq
    sla_attributes.each do |sla_attr|
      @match_tolerance  =  0
      @meet_tolerance   =  0
      @exceed_tolerance =  0


      breakdown_data["#{sla_attr}"] = {}
      breakdown_data["#{sla_attr}"]["match_suppliers"] = []
      breakdown_data["#{sla_attr}"]["meet_suppliers"] = []
      breakdown_data["#{sla_attr}"]["exceed_suppliers"] = []
      breakdown_data["#{sla_attr}"]["suppliers"] = []
      suppliers.each do |supplier|

        bsls = BusinessServiceLine.joins(steps: [supplier_steps: [:supplier]])
                                  .where(suppliers: {id: supplier.id})
                                  .where("supplier_steps.party_type IN (?)", filter_by_party_type)
                                  .includes(:sla, :risk_appetites)

        bsls.each do |bsl|
          bsl_sla_val             = bsl.sla[sla_attr]
          supplier_sla_val        = supplier.sla[sla_attr]
          risk_appetite           = bsl.risk_appetites.where(kind: sla_attr)&.first
          risk_appetite_val       = risk_appetite&.amount

          if bsl_sla_val && supplier_sla_val && risk_appetite_val
            if risk_appetite.percentage_amount?
              result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
              self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
            else
              result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
              self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
            end
            supplier_data = {
              id: supplier.id,
              name: supplier.name,
              match_tolerance: @match_tolerance,
              meet_tolerance: @meet_tolerance,
              exceed_tolerance: @exceed_tolerance,
              supplier_agreed_impact_tolerance: supplier.sla[sla_attr],
              firm_impact_tolerance: bsl_sla_val,
              difference: bsl_sla_val - supplier.sla[sla_attr],
              total_number_of_critical_steps: supplier.critical_supplier_steps.count,
              resilience_id: supplier.resilience_tickets.present? ? supplier.resilience_tickets.last&.rgid : 'N/A'
            }
            breakdown_data["#{sla_attr}"]["#{result[1]}_suppliers"] << supplier_data
            breakdown_data["#{sla_attr}"]["#{result[1]}_suppliers"] = breakdown_data["#{sla_attr}"]["#{result[1]}_suppliers"].uniq {|a| a[:id]}
          end
        end
      end
      breakdown_data["#{sla_attr}"][:match_tolerance]  = @match_tolerance
      breakdown_data["#{sla_attr}"][:meet_tolerance]   = @meet_tolerance
      breakdown_data["#{sla_attr}"][:exceed_tolerance] = @exceed_tolerance
      breakdown_data["#{sla_attr}"][:total_tolerance]  = @match_tolerance + @meet_tolerance + @exceed_tolerance
      breakdown_data[:overall_tolerance]               += @match_tolerance + @meet_tolerance + @exceed_tolerance
    end
    breakdown_data
  end
end