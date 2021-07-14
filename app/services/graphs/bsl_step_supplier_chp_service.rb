class Graphs::BslStepSupplierChpService < ApplicationService
  COLORS = %w[#6BEAB3 #367C5C #CDFAF1 #05b368]

  def initialize(args)
    @bsl  = BusinessServiceLine.find(args[:bsl])
    @data = {}
  end

  attr_reader :bsl, :data

  def call
    data[:overall]   = overall
    data[:breakdown] = breakdown

    data
  end

  private

  def overall
    datum = {}

    chp_suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                            .where(business_service_lines: { id: bsl.id })
                            .group_by { |s| s.cloud_hosting_provider }

    datum[:total] = chp_suppliers.values.flatten.size
    datum[:graph] = []

    CloudHostingProvider.all.each_with_index do |chp, index|
      suppliers = chp_suppliers[chp] || []
      datum[:graph] << {
        name:  chp.short_name,
        y:     datum[:total].zero? ? 0 : ((suppliers.size / datum[:total].to_f) * 100).round(2),
        color: COLORS[index],
        value: suppliers.size,
        logo:  chp.logo
      }
    end

    datum
  end

  def breakdown
    datum = {}

    critical_suppliers  = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                                  .where(business_service_lines: { id: bsl.id })
                                  .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:critical] })
                                  .group_by { |s| s.cloud_hosting_provider.name }
                                  .each_with_object({}) {|(k, v), h| h[k] = v.group_by { |s| s.consumption_model } }

    important_suppliers = Supplier.joins(supplier_steps: [step: [:business_service_line]])
                                  .where(business_service_lines: { id: bsl.id })
                                  .where(supplier_steps: { importance_level: SupplierStep.importance_levels[:important] })
                                  .group_by { |s| s.cloud_hosting_provider.name }
                                  .each_with_object({}) {|(k, v), h| h[k] = v.group_by { |s| s.consumption_model } }

    CloudHostingProvider.all.each do |chp|
      datum[chp.name] = {
        name: chp.name,
        logo: chp.logo,
        consumption_models: {}
      }
      Supplier.real_consumption_models.keys.each do |cm|
        datum[chp.name][:consumption_models][cm] = {}

        critical_count   = (critical_suppliers.dig(chp.name, cm)&.size  || 0)
        importance_count = (important_suppliers.dig(chp.name, cm)&.size || 0)
        total_count      = critical_count + importance_count

        datum[chp.name][:consumption_models][cm][:total] = total_count
        datum[chp.name][:consumption_models][cm][:graph] = []
        datum[chp.name][:consumption_models][cm][:graph] << {
          name:     'critical',
          y:        total_count.zero? ? 0 : ((critical_count / total_count.to_f) * 100).round(2),
          color:    COLORS[0],
          value: critical_count
        }
        datum[chp.name][:consumption_models][cm][:graph] << {
          name:     'important',
          y:        total_count.zero? ? 0 : ((importance_count / total_count.to_f) * 100).round(2),
          color:    COLORS[1],
          value: importance_count
        }
      end
    end

    datum
  end
end
