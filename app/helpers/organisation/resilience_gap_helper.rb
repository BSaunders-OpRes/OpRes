module Organisation::ResilienceGapHelper
  def find_sla_difference(sla_attr_name, bsl_val, supp_val )
    if(sla_attr_name == 'service_level_agreement' || sla_attr_name == 'service_level_objective')
      "#{(bsl_val - supp_val).round(2)} %"
    else
      "#{(supp_val - bsl_val).round(2)} min"
    end
  end
end
