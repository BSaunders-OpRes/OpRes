class Graphs::GlobalInstitutionService < Graphs::BaseService

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def call
    data[:overall] = overall
  end

  private

  def overall
    datum = {}
    organisational_unit.inclusive_children.select {|a| a.type == "Units::Institution"}.uniq {|a| a.institution_id}.each do |unit_institution|
      datum[unit_institution.institution.name] = {}
      institution_nodes = []
      nodes             = filter_data
      other_banks       = organisational_unit.inclusive_children.select {|a| a.type == "Units::Institution" && a.institution_id != unit_institution.institution.id}
      other_banks.each do |bank|
        institution_nodes << unit_institution.id
        institution_nodes << unit_institution.parent.id
        institution_nodes << unit_institution.parent.parent.id
      end
      nodes = nodes.reject {|e| institution_nodes.include?(e)}
      bsls      = BusinessServiceLine.where(unit_id: nodes)

      datum[unit_institution.institution.name][:bank_info] = {}
      datum[unit_institution.institution.name][:bank_info][:total_business_services] = bsls.count
      datum[unit_institution.institution.name][:bank_info][:total_firm_hosted_systems] = 0
      datum[unit_institution.institution.name][:bank_info][:total_3rd_party_suppliers] = 0
      datum[unit_institution.institution.name][:bank_info][:total_4th_party_suppliers] = 0

      total = bsls.count * 120
      total_sum = 0
      @match_tolerance  =  0
      @meet_tolerance   =  0
      @exceed_tolerance =  0

      bsls.each do |bsl|
        suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                            .where(business_service_lines: { id: bsl.id }).uniq
        suppliers.each do |supplier|
          datum[unit_institution.institution.name][:bank_info][:total_firm_hosted_systems] += 1 if supplier.supplier_steps.where(party_type: SupplierStep.party_types["firm-hosted"]).present?
          datum[unit_institution.institution.name][:bank_info][:total_3rd_party_suppliers] += 1 if supplier.supplier_steps.where(party_type: SupplierStep.party_types["3rd-party"]).present?
          datum[unit_institution.institution.name][:bank_info][:total_4th_party_suppliers] += 1 if supplier.supplier_steps.where(party_type: SupplierStep.party_types["4th-party"]).present?

          bsl.excluded_risk_appetites.each do |risk_appetite|
            bsl_sla_val       = bsl.sla[risk_appetite.kind]
            supplier_sla_val  = supplier.sla[risk_appetite.kind]
            risk_appetite_val = risk_appetite&.amount
            if bsl_sla_val && supplier_sla_val && risk_appetite_val
              if risk_appetite.percentage_amount?
                result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
                self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
                total_sum = total_sum + result[0]&.to_i
              else
                result = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)
                self.instance_variable_set("@#{result[1]}_tolerance".to_sym, eval("@#{result[1]}_tolerance")+1)
                total_sum = total_sum + result[0]&.to_i
              end
            end
          end
        end
      end

      datum[unit_institution.institution.name][:total]            = @match_tolerance + @meet_tolerance + @exceed_tolerance
      datum[unit_institution.institution.name][:match_tolerance]  = @match_tolerance
      datum[unit_institution.institution.name][:meet_tolerance]   = @meet_tolerance
      datum[unit_institution.institution.name][:exceed_tolerance] = @exceed_tolerance
      datum[unit_institution.institution.name][:graph]     = []

      datum[unit_institution.institution.name][:graph] << {
        name:  'Match Tolerance',
        y:     datum[unit_institution.institution.name][:total].zero? ? 0 : ((@match_tolerance / datum[unit_institution.institution.name][:total].to_f) * 100).round(2),
        color: COLORS[0],
        count: @match_tolerance
      }

      datum[unit_institution.institution.name][:graph] << {
        name:  'Meet Tolerance',
        y:     datum[unit_institution.institution.name][:total].zero? ? 0 : ((@meet_tolerance / datum[unit_institution.institution.name][:total].to_f) * 100).round(2),
        color: COLORS[1],
        count: @meet_tolerance
      }

      datum[unit_institution.institution.name][:graph] << {
        name:  'Exceed Tolerance',
        y:     datum[unit_institution.institution.name][:total].zero? ? 0 : ((@exceed_tolerance / datum[unit_institution.institution.name][:total].to_f) * 100).round(2),
        color: COLORS[2],
        count: @exceed_tolerance
      }
      datum[unit_institution.institution.name][:bank_info][:total_number_of_resilience_gaps] = @exceed_tolerance
    end
    # :most_compliant_region
    # :least_compliant_region
    # :most_compliant_subregion
    # :least_compliant_subregion
    # :most_compliant_country
    # :least_compliant_country
    # :most_compliant_brand
    # :least_compliant_brand
    # :most_used_cloud_supplier
    datum
  end
end
