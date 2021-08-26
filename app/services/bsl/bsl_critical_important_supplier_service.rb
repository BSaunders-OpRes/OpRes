class Bsl::BslCriticalImportantSupplierService < Bsl::BaseService
  # Individual supplier breakdown along its bsl.

  attr_reader :supplier, :bsl, :data

  def call
    @supplier  = Supplier.find_by_id(args.dig('id') || args.dig('supplier'))
    @bsl       = BusinessServiceLine.find_by_id(args.dig('bsl_id')) if args.dig('bsl_id').present?

    @data  = supplier_breakdown
    data
  end

  private

  def supplier_breakdown

    datum = []
    supplier_steps = SupplierStep.includes(step: [:business_service_line]).where(supplier_steps: {supplier_id: supplier.id})
    supplier_steps = supplier_steps.where(business_service_lines: { id: bsl.id }) if args.dig('bsl_id').present?

    supplier_steps&.each do |supplier_step|
      break_down = { 'supplier_name': supplier_step&.supplier&.name, 'party_type': supplier_step.party_type,
                     'bsl_name':  supplier_step&.step&.business_service_line&.name, 'tier': supplier_step&.step&.business_service_line&.tier,
                      'total_critical_steps': @bsl.supplier_steps.critical.supplier_based(supplier.id).size , 'total_important_steps': @bsl.supplier_steps.important.supplier_based(supplier.id).size  }
      datum << break_down
    end
    datum
  end
end


