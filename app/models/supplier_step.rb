class SupplierStep < ApplicationRecord
  # Associations #
  belongs_to :step
  belongs_to :supplier

  # Enums #
  enum party_type:       %i[firm-hosted 3rd-party 4th-party]
  enum importance_level: %i[critical important]

  scope :supplier_based,  ->(id) { where supplier_id: id }

  # Methods #
  class << self
    def selected_supplier_html
      <<~HTML
        <div class='col-sm-6 mb-2 bsl-step-supplier-selected-container'>
          <div class='card border-top-0 border-right-0 border-bottom-0 border-card-{{PARTY_TYPE_CLASS}} h-130px'>
            <div class='card-body p-3'>
              <span class='d-flex align-items-center mb-3'>
                <i class='fa fa-ellipsis-v' aria-hidden='true'></i>
                <i class='fa fa-ellipsis-v ml-1' aria-hidden='true'></i>
                <span class='font-12 font-600 ml-2 text-capitalize flex-1'>
                  {{SUPPLIER_NAME}}
                  <span class='d-none'>{{SUPPLIER_FIELD}}</span>
                </span>
                <a href='javascript:void(0);' class='text-black text-decoration-none bsl-step-supplier-selected-bin' data-step='{{BIN_STEP_ID}}' data-supplier='{{BIN_SUPPLIER_ID}}'>
                  <i class='fa fa-trash font-12 cursor-pointer delete-supplier' aria-hidden='true'></i>
                </a>
              </span>
              <ul class='list-group p-0 list-unstyled'>
                <li class='font-12 text-capitalize font-weight-normal'>
                  {{SUPPLIER_STEP_PARTY_TYPE}}
                  <span class='d-none'>{{SUPPLIER_STEP_PARTY_TYPE_FIELD}}</span>
                </li>
                <li class='font-12 text-capitalize font-weight-normal'>
                  {{SUPPLIER_STEP_IMPORTANCE_LEVEL}}
                  <span class='d-none'>{{SUPPLIER_STEP_IMPORTANCE_LEVEL_FIELD}}</span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      HTML
    end
  end
end
