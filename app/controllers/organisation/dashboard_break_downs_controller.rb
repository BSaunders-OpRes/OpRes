class Organisation::DashboardBreakDownsController < Organisation::BaseController
  before_action :managing_country_units, only: %i[cloud_service_provider_breakdown system_supplier_resilience_indicator]

  def business_service_tiers
    @bsls                    = BusinessServiceLine.where(unit_id: managing_institution_units.ids)
    @suppliers               = Supplier.where(id: managing_country_units.ids)
    @bsl_regional_tiers      = @bsls.group_by{|bsl| bsl.unit.parent.parent.region.name}
                               .each_with_object({}) {|(k, v), h| h[k] = v.group_by { |s| s.tier } }
    @bsls_tier               = @bsls.group_by(&:tier)

    @managing_regions        = current_user.managing_regions
    args    = { bsl: @bsls&.pluck(:id)}

    @bsl_impact_tolerances   = Graphs::ImpactToleranceBslsService.call(args.stringify_keys)

    @bsl_tiers = {}
    BusinessServiceLine.tiers.each do |tier, index|
      Region.all.each do |region|
        third_party_key  = "#{region.lower_name}_#{tier}_third_party_suppliers"
        fourth_party_key = "#{region.lower_name}_#{tier}_fourth_party_suppliers"
        internal_system  = "#{region.lower_name}_#{tier}_internal_systems"
        resilence_gap    = "#{region.lower_name}_#{tier}_resilience_gaps"

        args    = { bsl: @bsl_regional_tiers.dig(region.name, tier)&.pluck(:id)}

        exceed_tolerance_count = Graphs::ExceedResilienceSupplierService.call(args.stringify_keys)
        @bsl_tiers[resilence_gap]    = exceed_tolerance_count
        @bsl_tiers[internal_system]  = Supplier.joins(supplier_steps: [step: [:business_service_line]]).where(business_service_lines: { id: @bsl_regional_tiers.dig(region.name, tier)&.pluck(:id) })
        @bsl_tiers[third_party_key]  = SubSuppliers::ThirdPartySupplier.joins(supplier: [supplier_steps: [step: [:business_service_line]]])
                                                                      .where(business_service_lines: { id: @bsl_regional_tiers.dig(region.name, tier)&.pluck(:id) })
        @bsl_tiers[fourth_party_key] = SubSuppliers::FourthPartySupplier.joins(supplier: [supplier_steps: [step: [:business_service_line]]])
                                                                       .where(business_service_lines: { id: @bsl_regional_tiers.dig(region.name, tier)&.pluck(:id) })
      end
    end

  end

  def cloud_service_provider_breakdown
    @data = CHP::OverviewCharts.call({organisational_unit: organisational_unit})
  end

  def critical_important_system
    args = {
      'current_user' =>  current_user,
      'organisational_unit' =>  organisational_unit
    }
    @query = params[:query]
    @type = params[:type]
    @importance_level = params[:supplier_type] if params[:supplier_type].present?
    if @type.blank?
      @suppliers = Supplier.where(unit_id: managing_nodes).group_by{ |e| e.consumption_model }
      @cm_model = params[:cm_model].present? ? params[:cm_model]: 'iaas'
      @suppliers = Supplier.where(unit_id: managing_nodes).where("name ILIKE ?", "%#{params[:query]}%").where(consumption_model: params[:cm_model]) if params[:query].present?
      if @cm_model == 'paas'
        @suppliers = @suppliers['paas'] unless params[:query].present?
        @p_active = 'active'
      elsif @cm_model == 'saas'
        @suppliers = @suppliers['saas'] unless params[:query].present?
        @s_active = 'active'
      else
        @suppliers = @suppliers['iaas'] unless params[:query].present?
        @i_active = 'active'
      end
    else
      @private_suppliers = Supplier.where(unit_id: managing_nodes).joins(:supplier_steps).where(supplier_steps: { party_type: 'firm-hosted' }).where("name ILIKE ?", "%#{params[:query]}%").where(consumption_model: params[:cm_model])
    end
    @regional_filters = params[:regions] if params[:regions].present?
    @countries_filters = params[:countries]  if params[:countries].present?
    @firms_filters = params[:firms] if params[:firms].present?
    @products_filters = params[:products] if params[:products].present?
    @regions = Unit.where(id: managing_nodes).where(type:"Units::Regional")
    @countries = Unit.where(id: managing_nodes).where(type:"Units::Country")
    @intitutions = Unit.where(id: managing_nodes).where(type:"Units::Institution")
    @products = Product.joins(:units).where(units: { id: @intitutions.ids }).uniq
    @private_suppliers = Supplier.where(unit_id: managing_nodes).joins(:supplier_steps).where(supplier_steps: { party_type: 'firm-hosted' }).where(consumption_model: @cm_model) unless @type.present?
    if params[:supplier_type].present?
      @conformant_suppliers = ConformanceSupplierService.new(args, params).conformant_suppliers_data
      @non_conformant_suppliers = @conformant_suppliers.sort{|a,b| b[1][:total_impact_tolerance] <=> a[1][:total_impact_tolerance]}.reverse.to_h
    else
      @conformant_suppliers = ConformanceSupplierService.new(args, params).conformant_suppliers_data
      @non_conformant_suppliers = @conformant_suppliers.sort{|a,b| b[1][:total_impact_tolerance] <=> a[1][:total_impact_tolerance]}.reverse.to_h
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def private_cloud
    
  end

  def breakdown
    @supplier = Supplier.find_by(id: params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def impact_tolerance_appetite; end

  def system_supplier_resilience_indicator
    args = {
      'current_user' =>  current_user,
      'organisational_unit' =>  organisational_unit,
      'filters' => (params[:filters] || ActionController::Parameters.new).permit!.to_h
    }
    @impact_tolerance_breakdowns  = BreakdownService.new(args).calculate_breakdown
    @conformant_suppliers         = ConformanceSupplierService.new(args).conformant_suppliers_data
    @non_conformant_suppliers     = @conformant_suppliers.sort{|a,b| b[1][:total_impact_tolerance] <=> a[1][:total_impact_tolerance]}.reverse.to_h
  end

  def impact_tolerance_breakdown
    args = {
      'current_user' =>  current_user,
      'organisational_unit' =>  organisational_unit,
      sla_attr: params.dig(:sla_attr)
    }
    @type                       = params.dig(:type)
    @sla_attr                   = params.dig(:sla_attr)
    @impact_tolerance_breakdown = BreakdownService.new(args).calculate_breakdown
  end
end
