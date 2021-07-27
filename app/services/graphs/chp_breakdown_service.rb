class Graphs::ChpBreakdownService < ApplicationService
  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def initialize(args)
    @data = {}
    @args = args
    @organisational_unit = args['organisational_unit']
    @current_user = args['current_user']
  end

  attr_reader :args, :data

  def call
    nodes     = args.dig('organisational_unit').inclusive_children.map(&:id)
    suppliers = Supplier.where(unit_id: nodes).group_by(&:cloud_hosting_provider)

    data[:total] = suppliers.values.flatten.size
    data[:graph] = []

    CloudHostingProvider.all.each_with_index do |obj, number|
      spls = suppliers[obj] || []
      data[:graph] << {
        name: obj.short_name,
        y: data[:total].zero? ? 0 : ((spls.size / data[:total].to_f) * 100).round(2),
        color: COLORS[number],
        value: spls.size
      }
    end

    data
  end
end