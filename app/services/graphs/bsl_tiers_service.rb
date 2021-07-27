class Graphs::BslTiersService < ApplicationService
  # BSL breakdown by tiers.

  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def initialize(args)
    @args = args
    @data = {}
  end

  attr_reader :args, :data

  def call
    nodes     = args.dig('organisational_unit').inclusive_children.map(&:id)
    tier_bsls = BusinessServiceLine.where(unit_id: nodes).group_by(&:tier)

    data[:total] = tier_bsls.values.flatten.size
    data[:graph] = []

    BusinessServiceLine.tiers.each do |tier, number|
      bsls = tier_bsls[tier] || []
      data[:graph] << {
        name:  tier.humanize,
        y:     data[:total].zero? ? 0 : ((bsls.size / data[:total].to_f) * 100).round(2),
        color: COLORS[number],
        value: bsls.size
      }
    end

    data
  end
end
