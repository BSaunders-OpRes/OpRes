class Graphs::SupplierSystemBreakdownService < Graphs::BaseService
  # supplier system break down.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  attr_reader :bsl

  def call
    @bsl      = BusinessServiceLine.find(args['bsl'])
    data[:overall] = overall

    data
  end

  private

  def overall
    datum = {}
    datum[:suppliers]         = []
    all_supplier_steps        = bsl.supplier_steps
    unique_supplier_steps     = all_supplier_steps.uniq(&:supplier_id)

    unique_supplier_steps&.each do |supplier_step|
      total_sum = 0
      sla_attr_status = []
      sla_attr = {}

      bsl.risk_appetites.each do |risk_appetite|
        bsl_sla_val       = bsl.sla[risk_appetite.kind]
        supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
        risk_appetite_val = risk_appetite&.amount
        if bsl_sla_val && supplier_sla_val && risk_appetite_val
          if risk_appetite.percentage_amount?
            result    = find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier_step.supplier.sla[risk_appetite.kind], risk_appetite.amount)
            sla_attr[risk_appetite.kind] = result[1]
            total_sum =  total_sum + result[0]&.to_i
          else
            result    = find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier_step.supplier.sla[risk_appetite.kind], risk_appetite.amount)
            sla_attr[risk_appetite.kind] = result[1]
            total_sum =  total_sum + result[0]&.to_i
          end
          sla_attr_status << sla_attr
        end
      end
      datum[:suppliers] << {
        name:                  supplier_step.supplier.name,
        id:                    supplier_step.supplier.id,
        logo:                  supplier_step.supplier.cloud_hosting_provider.logo,
        consumption_model:     supplier_step.supplier.consumption_model,
        critical_steps_total:  all_supplier_steps.critical&.where(supplier_id: supplier_step.supplier.id).size,
        important_steps_total: all_supplier_steps.important&.where(supplier_id: supplier_step.supplier.id).size,
        conformance_score:     ((total_sum/120.to_f)*100).round(2),
        sla_attr:              supplier_step.supplier.sla,
        third_parties:         supplier_step.supplier.third_party_suppliers,
        fourth_parties:        supplier_step.supplier.fourth_party_suppliers,
        sla_attr_status:       sla_attr_status
      }
    end
    datum
  end
end
