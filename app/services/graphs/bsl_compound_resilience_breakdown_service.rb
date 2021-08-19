class Graphs::BslCompoundResilienceBreakdownService < Graphs::BaseService
  # Bsl compound resilience breakdown for finding the impact tolerance condition on bsl level.

  attr_reader :bsl, :supplier_ids, :sla_attr

  def call
    @bsl            = BusinessServiceLine.find_by_id(args.dig('bsl'))
    @supplier_ids   = args.dig('supplier')
    @sla_attr       = args.dig('sla_attr')
    data[:overall]  = overall
    data
  end

  private

  def overall
    datum = []

    supplier_steps = args.dig('supplier').present? &&  args.dig('supplier') == '0' ? [] : SupplierStep.where(supplier_id: supplier_ids).includes(supplier: :sla)

    supplier_steps.each do |supplier_step|
      supplier_data = { 'supplier_name': supplier_step.supplier.name, 'party_type': supplier_step.party_type, 'impact_tolerance': '', 'resilience_id': 0 }
      bsl_sla_val       = bsl.sla[sla_attr]
      supplier_sla_val  = supplier_step.supplier.sla[sla_attr]
      risk_appetite     = bsl.risk_appetites.where(kind: sla_attr)
      risk_appetite_val = risk_appetite.first&.amount

      if bsl_sla_val && supplier_sla_val && risk_appetite_val
        if risk_appetite.first.percentage_amount?
          result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.first.kind],  supplier_step.supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)
          supplier_data[:impact_tolerance] = result[1]
        else
          result = find_score_and_status_for_time(bsl.sla[risk_appetite.first.kind],  supplier_step.supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)
          supplier_data[:impact_tolerance] = result[1]
        end
      end
      datum << supplier_data
    end
    datum
  end
end


