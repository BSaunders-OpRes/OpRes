class Graphs::ResilienceRiskIndicatorService < Graphs::BaseService

  def call
    @overall_month = args.dig("filters", "months").present? ? args.dig("filters", "months").to_i : 3
    data[:overall] = overall
    data
  end

  private

  def overall
    risk_data                      = {}
    risk_data[:data]               = []
    risk_data[:xAxis]              = {}
    risk_data[:xAxis][:categories] = []
    nodes                          = filter_data
    ResilienceTicket.statuses.keys.each_with_index do |status, index|
      series_data = {
        name: status.capitalize,
        data: []
      }
      risk_data[:data] << series_data
    end

    if args.dig("filters", "tiers") && args.dig("filters", "tiers") != 'all'
      resilience_tickets = ResilienceTicket.joins(:unit, :business_service_line)
                                           .where(unit_id: nodes)
                                           .where(business_service_lines: { tier: BusinessServiceLine.tiers[args.dig("filters", "tiers")] })
                                           .uniq.group_by {|rt| rt.created_at.strftime('%m/%Y') }
    else
      resilience_tickets = ResilienceTicket.includes(:unit).where(unit_id: nodes).group_by {|rt| rt.created_at.strftime('%m/%Y') }
    end
    @overall_month.times.each do |om|
      c_date  = (DateTime.now - (om.month)).strftime('%m/%Y')

      risk_data[:xAxis][:categories] << c_date
      opened_tickets = resilience_tickets[c_date].present? ? resilience_tickets[c_date].select { |a| a.open? }.length : 0
      onhold_tickets = resilience_tickets[c_date].present? ? resilience_tickets[c_date].select { |a| a.onhold? }.length : 0
      closed_tickets = resilience_tickets[c_date].present? ? resilience_tickets[c_date].select { |a| a.close? }.length : 0

      risk_data[:data][0][:data] << opened_tickets
      risk_data[:data][1][:data] << onhold_tickets
      risk_data[:data][2][:data] << closed_tickets
    end

    risk_data
  end
end