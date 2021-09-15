class ConformanceSupplierService < Graphs::BaseService
  attr_accessor :filter

  def initialize(args, importance_level = nil)
    @args                = args
    @importance_level    = importance_level
    @current_user        = args.dig('current_user')
    @organisational_unit = args.dig('organisational_unit')

    @data = {}
  end

  def conformant_suppliers_data
    conformant_data = {}
    nodes           = organisational_unit&.inclusive_children&.map(&:id)
    if @importance_level.present?
      suppliers = Supplier.where(unit_id: nodes).joins(:supplier_steps).where(supplier_steps: { importance_level: @importance_level })
    else
      suppliers = Supplier.includes(:supplier_steps, :sla).where(unit_id: nodes)
    end
    suppliers.each do |supplier|
      conformant_data["#{supplier.id}"] = {}
      bsls = BusinessServiceLine.joins(steps: [supplier_steps: [:supplier]])
                                .where(suppliers: {id: supplier.id})
                                .includes(:sla, :risk_appetites)


      total = bsls.count
      total_sum = 0
      conformant_data["#{supplier.id}"][:name]                      = supplier.name
      conformant_data["#{supplier.id}"][:total_business_services]   = total
      conformant_data["#{supplier.id}"][:total_critical_suppliers]  = supplier.critical_supplier_steps.count
      conformant_data["#{supplier.id}"][:total_important_suppliers] = supplier.important_supplier_steps.count

      bsls.each do |bsl|
        bsl.risk_appetites.each do |risk_appetite|
          bsl_sla_val       = bsl.sla[risk_appetite.kind]
          supplier_sla_val  = supplier.sla[risk_appetite.kind]
          risk_appetite_val = risk_appetite&.amount
          if bsl_sla_val && supplier_sla_val && risk_appetite_val
            if risk_appetite.percentage_amount?
              total_sum = total_sum + find_score_and_status_for_percentage(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)[0]&.to_i
            else
              total_sum = total_sum + find_score_and_status_for_time(bsl.sla[risk_appetite.kind],  supplier.sla[risk_appetite.kind], risk_appetite.amount)[0]&.to_i
            end
          end
        end
      end
      conformant_data["#{supplier.id}"][:institution_count] = supplier&.unit&.children&.count
      conformant_data["#{supplier.id}"][:total_impact_tolerance] = total_sum
    end
    conformant_suppliers = conformant_data.sort{|a,b| b[1][:total_impact_tolerance] <=> a[1][:total_impact_tolerance]}.to_h

    conformant_suppliers
  end
end
