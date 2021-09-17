module Organisation::SuppliersHelper
  def titleize_last_alpha(key)
    dup_key = key.dup
    if dup_key!='Other'
      dup_key[dup_key.size-1] = dup_key[dup_key.size-1].capitalize
    end
    dup_key
  end

  def sla_compounded_resilience_posture_text(sla_attr)
    if sla_attr == 'service_level_agreement'
      'SLA conformance'
    elsif sla_attr == 'service_level_objective'
      'SLO conformance'
    elsif sla_attr == 'recovery_time_objective'
      'RTO conformance'
    elsif sla_attr == 'recovery_point_objective'
      'RPO conformance'
    elsif sla_attr == 'transactions_per_second'
      'TPS conformance'
    elsif sla_attr == 'response_time'
      'Response Time'
    elsif sla_attr == 'severity1'
      'incident sev 1 notification'
    elsif sla_attr == 'severity2'
      'incident sev 2 notification'
    elsif sla_attr == 'severity3'
      'incident sev 3 notification'
    elsif sla_attr == 'severity4'
      'incident sev 4 notification'
    elsif sla_attr == 'severity1_restoration'
      'incident sev 1 restoration'
    elsif sla_attr == 'severity2_restoration'
      'incident sev 2 restoration'
    elsif sla_attr == 'severity3_restoration'
      'incident sev 3 restoration'
    elsif sla_attr == 'severity4_restoration'
      'incident sev 4 restoration'
    end
  end

  def sla_compounded_resilience_breakdown_text(sla_attr)
    if sla_attr == 'service_level_agreement'
      'SLA'
    elsif sla_attr == 'service_level_objective'
      'SLO'
    elsif sla_attr == 'recovery_time_objective'
      'RTO'
    elsif sla_attr == 'recovery_point_objective'
      'RPO'
    elsif sla_attr == 'transactions_per_second'
      'TPS'
    elsif sla_attr == 'response_time'
      'Response Time'
    elsif sla_attr == 'severity1'
      'severity 1 notification'
    elsif sla_attr == 'severity2'
      'severity 2 notification'
    elsif sla_attr == 'severity3'
      'severity 3 notification'
    elsif sla_attr == 'severity4'
      'severity 4 notification'
    elsif sla_attr == 'severity1_restoration'
      'severity 1 restoration'
    elsif sla_attr == 'severity2_restoration'
      'severity 2 restoration'
    elsif sla_attr == 'severity3_restoration'
      'severity 3 restoration'
    elsif sla_attr == 'severity4_restoration'
      'severity 4 restoration'
    end
  end

   def sla_full_form(sla_attr)
    if sla_attr == 'severity1'
      'severity 1 notification'
    elsif sla_attr == 'severity2'
      'severity 2 notification'
    elsif sla_attr == 'severity3'
      'severity 3 notification'
    elsif sla_attr == 'severity4'
      'severity 4 notification'
    else
      sla_attr.humanize
    end
  end

  def check_logo(social_account_name)
    case social_account_name
    when 'LinkedIn'
      'fa fa-linkedin-square'
    when 'Twitter'
      'fa fa-twitter-square'
    when 'Facebook'
      'fa fa-facebook-square'
    when 'Instagram'
      'fa fa-instagram'
    when  'Website'
      'fa fa-globe'
    end
  end
end
