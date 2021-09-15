class Graphs::CreateResilienceTicketsService < Graphs::BaseService
  def call
    # destroy all resilience tickets
    ResilienceTicket.destroy_all
    # create resilience tickets
    BusinessServiceLine.all&.each do |bsl|
      bsl.supplier_steps&.each do |supplier_step|
        bsl.risk_appetites.each do |risk_appetite|
          bsl_sla_val       = bsl.sla[risk_appetite.kind]
          supplier_sla_val  = supplier_step.supplier.sla[risk_appetite.kind]
          risk_appetite_val = risk_appetite&.amount
          if bsl_sla_val && supplier_sla_val && risk_appetite_val
            if risk_appetite.percentage_amount?
              result = find_score_and_status_for_percentage(bsl_sla_val, supplier_sla_val, risk_appetite_val)
            else
              result = find_score_and_status_for_time(bsl_sla_val, supplier_sla_val, risk_appetite_val)
            end
            if result[1] == 'exceed'
              resilience_id = ResilienceTicket.where(unit: bsl.unit)&.last&.rgid.present? ? (ResilienceTicket.where(unit: bsl.unit).last.rgid&.split('-')[1].to_i+1).to_s :  '100000'.to_s
              unless ResilienceTicket.find_by(sla_attr: risk_appetite.kind, business_service_line: bsl, unit: bsl.unit, supplier: supplier_step.supplier)
                bsl.resilience_tickets << ResilienceTicket.create( user: bsl.organisation_root_users.first, rgid: 'RES-'+resilience_id, sla_attr: risk_appetite.kind, business_service_line: bsl, unit: bsl.unit, supplier: supplier_step.supplier)
              end
            else
              # for destroying the ticket which is not exceeding now
              ResilienceTicket.find_by(sla_attr: risk_appetite.kind,business_service_line: bsl, unit: bsl.unit, supplier: supplier_step.supplier)&.destroy
            end
          end
        end
      end
    end
  end
end
