class Graphs::BslTiersService < Graphs::BaseService
  # BSL breakdown by tiers.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def call
    if args.dig('bsl').present?
      tier_bsls = args.dig('bsl') == '0' ? [] : BusinessServiceLine.where(id: args.dig('bsl')).group_by(&:tier)
    else
      nodes     = organisational_unit.inclusive_children.map(&:id)
      tier_bsls = BusinessServiceLine.where(unit_id: nodes).group_by(&:tier)
    end

    data[:total] = tier_bsls&.empty? ? 0 : tier_bsls.values.flatten.size
    data[:graph] = []

    BusinessServiceLine.tiers.each do |tier, number|
      bsls =  tier_bsls.present? ? tier_bsls[tier] : []
      data[:graph] << {
        name:  tier.humanize,
        y:     data[:total].zero? || bsls.nil? || bsls&.empty? ? 0 : ((bsls.size / data[:total].to_f) * 100).round(2),
        color: COLORS[number],
        value: bsls.nil? ? 0 : bsls.size
      }
    end
    data
  end
end
