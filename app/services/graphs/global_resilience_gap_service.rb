class Graphs::GlobalResilienceGapService < Graphs::BaseService

  def call
    @tier         = args.dig("tier")
    args["filters"].delete("institution_ids") if args["filters"]["institution_ids"].present? && args["filters"]["institution_ids"].include?("")
    args["filters"].delete("product_ids") if args["filters"]["product_ids"].present? && args["filters"]["product_ids"].include?("")
    args["filters"].delete("region_ids") if args["filters"]["region_ids"].present? && args["filters"]["region_ids"].include?("")
    args["filters"].delete("country_ids") if args["filters"]["country_ids"].present? && args["filters"]["country_ids"].include?("")

    nodes         = filter_data
    search_query  = args.dig("filters", "query").present? ? "resilience_tickets.rgid ILIKE (:key)" : ""
    sort_by       = args.dig("filters", "sort").present? ? args.dig("filters", "sort") : "asc"
    @resilience_tickets = ResilienceTicket.includes(:unit, :business_service_line)
                                          .where(unit_id: nodes)
                                          .where(business_service_lines: { tier: BusinessServiceLine.tiers[@tier] })
                                          .where(search_query, key: "%#{args.dig('filters', 'query') || '' }%")
                                          .order(risk_level: sort_by.to_sym)

    if args.dig("filters", "bsl").present?
      @resilience_tickets = @resilience_tickets.where(business_service_lines: { id: args.dig("filters", "bsl").to_i })
    end
    if args.dig("filters", "resilience_status").present?
      @resilience_tickets = @resilience_tickets.where("resilience_tickets.status = ?", args.dig("filters", "resilience_status").to_i)
    end
    if args.dig("filters", "resilience_id").present?
      @resilience_tickets = @resilience_tickets.where("resilience_tickets.rgid = ?", args.dig("filters", "resilience_id"))
    end
    if args.dig("filters", "resilience_risk_level").present?
      @resilience_tickets = @resilience_tickets.where("risk_level = ?", args.dig("filters", "resilience_risk_level").to_i)
    end

    @resilience_tickets
  end
end