class Graphs::GlobalResilienceGapService < Graphs::BaseService

  def call
    @tier         = args.dig("tier")
    nodes         = filter_data
    search_query  = args.dig("filters", "query").present? ? "resilience_tickets.rgid ILIKE (:key)" : ""
    sort_by       = args.dig("filters", "sort").present? ? args.dig("filters", "sort") : "asc"
    @resilience_tickets = ResilienceTicket.includes(:unit, :business_service_line)
                                          .where(unit_id: nodes)
                                          .where(business_service_lines: { tier: BusinessServiceLine.tiers[@tier] })
                                          .where(search_query, key: "%#{args.dig('filters', 'query') || '' }%")
                                          .order(risk_level: sort_by.to_sym)

    if args.dig("filters", "bsl_ids").present? && args.dig("filters", "bsl_ids").exclude?('all')
      @resilience_tickets = @resilience_tickets.where(business_service_lines: { id: args.dig("filters", "bsl_ids").map { |a| a.to_i }  })
    end
    if args.dig("filters", "resilience_risk_level").present?
      @resilience_tickets = @resilience_tickets.where("risk_level = ?", args.dig("filters", "resilience_risk_level").to_i)
    end

    @resilience_tickets
  end
end