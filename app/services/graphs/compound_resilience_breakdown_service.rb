class Graphs::CompoundResilienceBreakdownService < Graphs::BaseService
  # compound resilience breakdown for finding the impact tolerance condition on bsl level.

  attr_reader :supplier, :bsl_ids, :sla_attr

  def call
    @supplier = Supplier.find(args.dig('supplier'))
    @bsl_ids  = args.dig('bsl')
    @sla_attr = args.dig('sla_attr')
    data[:overall]   = overall

    data
  end

  private

  def overall
    datum = []

    bsls = args.dig('bsl').present? &&  args.dig('bsl') == '0' ? [] : BusinessServiceLine.includes(:sla).where(business_service_lines: {id: bsl_ids})

    bsls.each do |bsl|
      bsl_data = { 'bsl_name': bsl.name, 'tier': bsl.tier, 'impact_tolerance': '', 'resilience_id': 0 }
      bsl_sla_val       = bsl.sla[sla_attr]
      supplier_sla_val  = supplier.sla[sla_attr]
      risk_appetite     = bsl.risk_appetites.where(kind: sla_attr)
      risk_appetite_val = risk_appetite.first&.amount

      if bsl_sla_val && supplier_sla_val && risk_appetite_val
        if risk_appetite.first.percentage_amount?
          result = find_score_and_status_for_percentage(bsl.sla[risk_appetite.first.kind],  supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)
          bsl_data[:impact_tolerance] = result[1]
        else
          result = find_score_and_status_for_time(bsl.sla[risk_appetite.first.kind],  supplier.sla[risk_appetite.first.kind], risk_appetite.first.amount)
          bsl_data[:impact_tolerance] = result[1]
        end
      end
      datum << bsl_data
    end

    datum
  end
end


