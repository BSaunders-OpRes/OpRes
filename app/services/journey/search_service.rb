class Journey::SearchService < ApplicationService
  def initialize(args = {})
    @args           = args
    @current_user   = args.dig(:current_user)
    @nodes          = args.dig(:organisational_unit).inclusive_children.pluck(:id)
    @filter         = args.dig(:filter)
  end

  def call
    data            = []
    bsls_data       = get_bsls_data
    suppliers_data  = get_suppliers_data
    resilience_data = get_resilience_data
    data << bsls_data << suppliers_data << resilience_data

    return data.flatten
  end

  def get_suppliers_data
    suppliers = Supplier.where(unit_id: @nodes)
                        .where("name ILIKE (?)", "%#{@filter}%")
    return suppliers.map {|supplier| {id: supplier.id, name: supplier.name, url: Rails.application.routes.url_helpers.organisation_supplier_path(supplier.id)}}
  end

  def get_bsls_data
    bsls = BusinessServiceLine.where(unit_id: @nodes)
                              .where("name ILIKE (?)", "%#{@filter}%")
    return bsls.map {|bsl| {id: bsl.id, name: bsl.name, url: Rails.application.routes.url_helpers.organisation_business_service_line_path(bsl.id)}}
  end

  def get_resilience_data
    resilience_ticket = ResilienceTicket.where(unit_id: @nodes)
                                        .where("rgid ILIKE (?)", "%#{@filter}%")
    return resilience_ticket.map {|rt| {id: rt.id, name: rt.rgid, url: Rails.application.routes.url_helpers.resilience_indicator_ticket_organisation_resilience_ticket_resilience_gap_path(id: rt.business_service_line_id, resilience_ticket_id: rt.id)}}
  end
end
