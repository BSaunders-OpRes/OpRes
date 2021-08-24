class Bsl::ChpSupplierService < Bsl::BaseService
  # Supplier on the basis of selected cloud hosting provider.

  attr_reader :bsl, :data

  def call
    @bsl  = BusinessServiceLine.find_by_id(args.dig('id') || args.dig('bsl'))

    @data  = supplier_consumption_model
    data
  end

  private

  def supplier_consumption_model

    supplier_with_consumption_model = Supplier.includes(:cloud_hosting_provider, supplier_steps: [step: [:business_service_line]])
                                              .where(business_service_lines: { id: bsl.id })
                                              .where('cloud_hosting_providers.name = ?', args.dig('chp_name'))
                                              .group_by(&:consumption_model)

    data = {}

    data['chp_name'] = args.dig('chp_name')
    data[args.dig('chp_name')] = {}
    supplier_with_consumption_model&.each do |consumption_model, suppliers|
      data[args.dig('chp_name')][consumption_model] = []
      suppliers&.each do |supplier|
        supplier_steps = supplier.supplier_steps
        supplier_steps&.each do |supplier_step|
          supplier_data = { 'supplier_name': supplier_step.supplier.name, 'party_type': supplier_step.party_type, 'chp_name': supplier.cloud_hosting_provider.name, 'total_critical_steps': @bsl.supplier_steps.critical.supplier_based(supplier.id).size, 'total_important_steps': @bsl.supplier_steps.important.supplier_based(supplier.id).size, 'supplier_id': supplier.id }
          data[args.dig('chp_name')][consumption_model] << supplier_data
        end
      end
    end
    data
  end
end


