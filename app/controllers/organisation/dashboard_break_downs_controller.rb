class Organisation::DashboardBreakDownsController < Organisation::BaseController
  def business_service_tiers
    @bsls                    = BusinessServiceLine.where(unit_id: managing_institution_units.ids)
    @suppliers               = Supplier.where(id: managing_country_units.ids)
    @bsl_regional_tiers      = @bsls.group_by{|bsl| bsl.unit.parent.parent.region.name}
                               .each_with_object({}) {|(k, v), h| h[k] = v.group_by { |s| s.tier } }
    @bsls_tier               = @bsls.group_by(&:tier)

    @managing_regions        = current_user.managing_regions

    @bsl_tiers = {}
    BusinessServiceLine.tiers.each do |tier, index|
      Region.all.each do |region|
        third_party_key  = "#{region.lower_name}_#{tier}_third_party_suppliers"
        fourth_party_key = "#{region.lower_name}_#{tier}_fourth_party_suppliers"
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
    @suppliers = Supplier.where(unit_id: managing_nodes).group_by{ |e| e.consumption_model }
    @private_suppliers = Supplier.joins(:supplier_steps).where(supplier_steps: { party_type: 'firm-hosted' }).group_by{ |e| e.consumption_model }
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
  def resilience_indicator_ticket; end
  def system_supplier_resilience_indicator; end
end
