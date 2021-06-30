module Organisation::RisksHelper
  def risk_appetite_tooltip(risk_appetite)
    display_name = RiskAppetite.kind_display_name[risk_appetite.kind]

    if risk_appetite.percentage_amount?
      "Please set the impact tolerance threshold for your #{display_name}. This should be the % figure you are willing to deviate from your target #{display_name}."
    elsif risk_appetite.minutes_amount?
      if risk_appetite.kind.include?('restoration')
        "Please set the impact tolerance threshold for #{display_name} incident restoration timeframes. This should be a time based figure you are willing to deviate from your target restoration timeframe."
      elsif risk_appetite.kind.include?('severity')
        "Please set the impact tolerance threshold for #{display_name} incident notification timeframes. This should be a time based figure you are willing to deviate from your target notification timeframe."
      else
        "Please set the impact tolerance threshold for your #{display_name}. This should be a time based figure you are willing to deviate from your target #{display_name}."
      end
    else
      ''
    end 
  end

  def risk_appetite_amount_value(risk_appetite)
    return nil if risk_appetite.amount.blank?

    risk_appetite.minutes_amount? ? risk_appetite.amount.to_i : risk_appetite.amount
  end
end
