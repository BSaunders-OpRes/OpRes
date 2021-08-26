module ApplicationHelper
  attr_reader :organisational_unit
  attr_reader :managing_units

  def new_or_create
    params[:action].in? %w[new create]
  end

  def organisation_dropdown_options
    childs = organisational_unit.inclusive_children
    childs = Unit.sort_children(childs)
    childs.pluck(:name, :id)
  end

  def determine_user_redirect_path
    if current_user&.application_admin?
      admin_dashboard_index_path
    elsif current_user&.root_user?
      organisation_dashboard_index_path
    elsif current_user&.super_or_standard_user?
      organisation_dashboard_index_path
    else
      root_path
    end
  end

  def hide_search_bar?
    params[:controller] == 'organisation/journeys'
  end

  def hide_side_bar?
    params[:controller] == 'organisation/journeys'
  end

  def toastr_flash_message
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}(\"#{message}\");</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join('\n').html_safe
  end

  def get_rag_status(compliance_evidence)
    case
    when  DateTime.now < compliance_evidence.created_at + (compliance_evidence.compliance_frequency.to_i - 1).days
      return '<div class="sm-circle bg-primary-green"></div>'
    when DateTime.now == compliance_evidence.created_at + (compliance_evidence.compliance_frequency.to_i - 1).days
      return '<div class="sm-circle bg-yellow"></div>'
    when DateTime.now > compliance_evidence.created_at + (compliance_evidence.compliance_frequency.to_i).days
      return '<div class="sm-circle bg-red"></div>'
    end
  end

  def compliance_tier_tooltip(tier)
    case tier
    when 'very_high'
      "These documents move to amber when they are in the final 80 days of their compliance window"
    when 'high'
      "These documents move to amber when they are in the final 60 days of their compliance window"
    when 'medium'
      "These documents move to amber when they are in the final 40 days of their compliance window"
    when 'low'
      "These documents move to amber when they are in the final 20 days of their compliance window"
    end
  end
  
  def render_fields_heading(field)
    "#{field} impact tolerances"
  end

  def set_tabs_id(key)
    case key
    when key == 'firm-hosted'
      'firm-hosted1'
    when key == '3rd-party'
      'third-party'
    when key == '4th-party'
      'fourth-party'
    end
  end

  def render_data(data)
    combined_data = []
    combined_data << {:name=>"Match Tolerance", :y=>data.dig(:overall, :total_match), :color=>"#6BEAB3", :count=> data.dig(:overall, :total_match)}
    combined_data << {:name=>"Meet Tolerance", :y=>data.dig(:overall, :total_meet), :color=>"#367C5C", :count=> data.dig(:overall, :total_meet)}
    combined_data << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, :total_exceed), :color=>"#CDFAF1", :count=> data.dig(:overall, :total_exceed)}

    combined_data
  end

  def breakdown_modal_heading(sla_attr, type)
    "#{sla_attr.titleize} -  Who #{type.titleize} Impact Tolerance"
  end

  def overview_region_headings
    %w(Total\ Business\ Service Total\ Resilience\ Gaps Total\ Internal\ Systems Total\ 3rd\ Party\ Suppliers Total\ 4th\ Party\ Suppliers)
  end

  def get_regional_data(orh, tier, region, bsl_regional_tiers = [], bsl_tiers = [])
    case orh
    when "Total Business Service"
      bsl_regional_tiers.dig(region, tier).present? ? bsl_regional_tiers.dig(region, tier).size : 0
    when "Total Resilience Gaps"
      0
    when "Total Internal Systems"
      0
    when "Total 3rd Party Suppliers"
      bsl_tiers.dig("#{region.downcase}_#{tier}_third_party_suppliers")&.size
    when "Total 4th Party Suppliers"
      bsl_tiers.dig("#{region.downcase}_#{tier}_fourth_party_suppliers")&.size
    end
  end

  def risk_appetite_by_tier(data)
    risk_appetite_data = {}
    BusinessServiceLine.tiers.keys.each do |tier|
      risk_appetite_data[tier] = {}
      risk_appetite_data[tier][:total_critical] = data.dig(:overall, tier,:total_critical) || 0
      risk_appetite_data[tier][:critical] = []
      risk_appetite_data[tier][:critical] << {:name=>"Match Tolerance", :y=>data.dig(:overall, tier,:critical_match_tolerance) || 0, :color=>"#6BEAB3", :count=> data.dig(:overall, tier,:critical_match_tolerance) || 0}
      risk_appetite_data[tier][:critical] << {:name=>"Meet Tolerance", :y=>data.dig(:overall, tier,:critical_meet_tolerance) || 0, :color=>"#367C5C", :count=> data.dig(:overall, tier,:critical_meet_tolerance) || 0}
      risk_appetite_data[tier][:critical] << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, tier,:critical_exceed_tolerance) || 0, :color=>"#CDFAF1", :count=> data.dig(:overall, tier,:critical_exceed_tolerance) || 0}

      risk_appetite_data[tier][:total_important] = data.dig(:overall, tier,:total_important) || 0
      risk_appetite_data[tier][:important] = []
      risk_appetite_data[tier][:important] << {:name=>"Match Tolerance", :y=>data.dig(:overall, tier,:important_match_tolerance) || 0, :color=>"#6BEAB3", :count=> data.dig(:overall, tier,:important_match_tolerance) || 0}
      risk_appetite_data[tier][:important] << {:name=>"Meet Tolerance", :y=>data.dig(:overall, tier,:important_meet_tolerance) || 0, :color=>"#367C5C", :count=> data.dig(:overall, tier,:important_meet_tolerance) || 0}
      risk_appetite_data[tier][:important] << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, tier,:important_exceed_tolerance) || 0, :color=>"#CDFAF1", :count=> data.dig(:overall, tier,:important_exceed_tolerance) || 0}
    end
    risk_appetite_data
  end
end

