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
      if message.class == Array
        text = "<script>toastr.#{type}(\"#{message.to_sentence}\");</script>"
      else
        text = "<script>toastr.#{type}(\"#{message}\");</script>"
      end
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

  def render_data(data, filters)
    combined_data = []
    if filters.present? && filters.dig("party_type_ids").present?
      if filters.dig("party_type_ids").include?("all")
        combined_data << {:name=>"Match Tolerance", :y=>data.dig(:overall, :total_match), :color=>"#6BEAB3", :count=> data.dig(:overall, :total_match)}
        combined_data << {:name=>"Meet Tolerance", :y=>data.dig(:overall, :total_meet), :color=>"#367C5C", :count=> data.dig(:overall, :total_meet)}
        combined_data << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, :total_exceed), :color=>"#CDFAF1", :count=> data.dig(:overall, :total_exceed)}
      else
        total_match = 0
        total_meet = 0
        total_exceed = 0
        filters.dig("party_type_ids").each do |i|
          total_match += data.dig(:overall, i.underscore, :total_match) || 0
          total_meet += data.dig(:overall, i.underscore, :total_meet) || 0
          total_exceed += data.dig(:overall, i.underscore, :total_exceed) || 0
        end
        combined_data << {:name=>"Match Tolerance", :y=>total_match, :color=>"#6BEAB3", :count=> total_match}
        combined_data << {:name=>"Meet Tolerance", :y=>total_meet, :color=>"#367C5C", :count=> total_meet}
        combined_data << {:name=>"Exceed Tolerance", :y=>total_exceed, :color=>"#CDFAF1", :count=> total_exceed}
      end
    else
      combined_data << {:name=>"Match Tolerance", :y=>data.dig(:overall, :total_match), :color=>"#6BEAB3", :count=> data.dig(:overall, :total_match)}
      combined_data << {:name=>"Meet Tolerance", :y=>data.dig(:overall, :total_meet), :color=>"#367C5C", :count=> data.dig(:overall, :total_meet)}
      combined_data << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, :total_exceed), :color=>"#CDFAF1", :count=> data.dig(:overall, :total_exceed)}
    end

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
      bsl_tiers.dig("#{region.downcase}_#{tier}_resilience_gaps") || 0
    when "Total Internal Systems"
      bsl_tiers.dig("#{region.downcase}_#{tier}_internal_systems")&.size
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
      risk_appetite_data[tier][:critical] << {:name=>"Meet Tolerance", :y=>data.dig(:overall, tier,:critical_meet_tolerance) || 0, :color=>"#E39A2B", :count=> data.dig(:overall, tier,:critical_meet_tolerance) || 0}
      risk_appetite_data[tier][:critical] << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, tier,:critical_exceed_tolerance) || 0, :color=>"#E4412E", :count=> data.dig(:overall, tier,:critical_exceed_tolerance) || 0}

      risk_appetite_data[tier][:total_important] = data.dig(:overall, tier,:total_important) || 0
      risk_appetite_data[tier][:important] = []
      risk_appetite_data[tier][:important] << {:name=>"Match Tolerance", :y=>data.dig(:overall, tier,:important_match_tolerance) || 0, :color=>"#6BEAB3", :count=> data.dig(:overall, tier,:important_match_tolerance) || 0}
      risk_appetite_data[tier][:important] << {:name=>"Meet Tolerance", :y=>data.dig(:overall, tier,:important_meet_tolerance) || 0, :color=>"#E39A2B", :count=> data.dig(:overall, tier,:important_meet_tolerance) || 0}
      risk_appetite_data[tier][:important] << {:name=>"Exceed Tolerance", :y=>data.dig(:overall, tier,:important_exceed_tolerance) || 0, :color=>"#E4412E", :count=> data.dig(:overall, tier,:important_exceed_tolerance) || 0}
    end
    risk_appetite_data
  end

  def institution_products
    products = []
    organisational_unit.institutions.each do |institution|
      institution.products.each do |product|
        products << product unless products.include?(product)
      end
    end
    products
  end

  def overview_heading(filters)
    if filters.present? && filters.dig("party_type_ids").present?
      if filters.dig("party_type_ids").include?("all")
        "Total Number of Impact Tolerances Measured"
      else
        "Total Number of #{filters.dig("party_type_ids").join(' & ')} Impact Tolerances Measured"
      end
    else
      "Total Number of Impact Tolerances Measured"
    end
  end

  def total_for_selected_supplier_type(data, filters)
    if filters.present? && filters.dig("party_type_ids").present?
      if filters.dig("party_type_ids").include?("all")
        data.dig(:overall, :total)
      else
        total = 0
        filters.dig("party_type_ids").each do |i|
          total += ((data.dig(:overall, i.underscore, :total_match) || 0) + (data.dig(:overall, i.underscore, :total_meet) || 0) + (data.dig(:overall, i.underscore, :total_exceed) || 0))
        end
        total
      end
    else
      data.dig(:overall, :total)
    end
  end

  def total_match_for_selected_supplier_type(data, filters)
    if filters.present? && filters.dig("party_type_ids").present?
      if filters.dig("party_type_ids").include?("all")
        data.dig(:overall, :total_match)
      else
        total = 0
        filters.dig("party_type_ids").each do |i|
          total += data.dig(:overall, i.underscore, :total_match) || 0
        end
        total
      end
    else
      data.dig(:overall, :total_match)
    end
  end

  def total_meet_for_selected_supplier_type(data, filters)
    if filters.present? && filters.dig("party_type_ids").present?
      if filters.dig("party_type_ids").include?("all")
        data.dig(:overall, :total_meet)
      else
        total = 0
        filters.dig("party_type_ids").each do |i|
          total += data.dig(:overall, i.underscore, :total_meet) || 0
        end
        total
      end
    else
      data.dig(:overall, :total_meet)
    end
  end

  def total_exceed_for_selected_supplier_type(data, filters)
    if filters.present? && filters.dig("party_type_ids").present?
      if filters.dig("party_type_ids").include?("all")
        data.dig(:overall, :total_exceed)
      else
        total = 0
        filters.dig("party_type_ids").each do |i|
          total += data.dig(:overall, i.underscore, :total_exceed) || 0
        end
        total
      end
    else
      data.dig(:overall, :total_exceed)
    end
  end

  def organisational_regions
    organisational_unit.children
  end

  def organisational_countries(params_data=nil)
    if params_data.present? && params_data.dig(:filters, :region_ids).present?
      return organisational_unit.children.select{|a| params_data.dig(:filters, :region_ids).include?(a.region_id.to_s)}.map {|a| a.children}.flatten.map {|b| b.country}
    else
      return organisational_unit.children.map {|a| a.children}.flatten.map {|b| b.country}
    end
  end

  def organisational_institution_ids
    managing_units.map(&:inclusive_children).flatten.select {|a| a.type == "Units::Institution"}
  end

  def specific_organisational_institution_ids(params_data)
    managing_units.map(&:inclusive_children).flatten.select {|a| a.type == "Units::Institution" && params_data.dig(:filters, :institution_ids).include?(a.institution_id.to_s) }.map(&:id)
  end

  def organisational_institutions
    managing_units.map(&:inclusive_children).flatten.select {|a| a.type == "Units::Institution"}.map {|a| a.institution}.uniq
  end

  def organisational_products
    Product.joins(:units).where(units: { id: organisational_institution_ids.map(&:id) }).uniq
  end

  def checkboxes_handler(params_data, ids_sym, id)
    params_data.dig(:filters, ids_sym.to_sym).present? && (params.dig(:filters, ids_sym.to_sym).include?("all") || params.dig(:filters, ids_sym.to_sym).include?(id.to_s)) ? true : false
  end

  def selected_count_filters(params_data, ids_sym)
    if params_data.dig(:filters, ids_sym.to_sym).present?
      if params.dig(:filters, ids_sym.to_sym).include?("all")
        case ids_sym
        when "sub_region_ids"
          return organisational_countries(params_data).length
        when "institution_ids"
          return organisational_institutions(params_data).length
        when "product_ids"
          return organisational_products.length
        when "country_ids"
          return organisational_countries(params_data).length
        end
      else
        return params.dig(:filters, ids_sym.to_sym).length
      end
    else
      return 0
    end
  end
end

