module Suppliers::SupplierStepConcern
  extend ActiveSupport::Concern
  included do
    def included_supplier_steps
      supplier_steps.includes(:supplier, step: :business_service_line)
    end

    def important_supplier_steps
      included_supplier_steps.important
    end

    def critical_supplier_steps
      included_supplier_steps.critical
    end

    def third_party_supplier_steps
      included_supplier_steps.send('3rd-party')
    end

    def fourth_party_supplier_steps
      included_supplier_steps.send('4th-party')
    end

    def firm_hosted_supplier_steps
      included_supplier_steps.send('firm-hosted')
    end
  end
end
