class Organisation::ComplianceEvidencesController < Organisation::BaseController
  before_action :load_supplier
  before_action :load_compliance_evidence, only: %i[edit update destroy]

  def index; end

  def new
    @compliance_evidence = @supplier.compliance_evidences.new
    @compliance_evidence.compliance_rules.build
  end

  def show; end

  def create
    @compliance_evidence = @supplier.compliance_evidences.new(compliance_evidence_params)
    if @compliance_evidence.save!
      flash.now[:notice] = "compliance evidence has been created successfully!"
    end
  end

  def edit; end

  def update
    if @compliance_evidence.update(compliance_evidence_params)
      flash.now[:notice] = 'compliance evidence has been updated successfully!'
    end
  end

  def destroy; end

  private

  def compliance_evidence_params
    params.require(:compliance_evidence).permit(:name, :description, :compliance_tier, :compliance_frequency,
      :compliance_document, compliance_rules_attributes: %i[id title reminder email_address tailored_message _destroy]
    )
  end

  def load_supplier
    @supplier = Supplier.find(params[:supplier_id])
  end

  def load_compliance_evidence
    @compliance_evidence = @supplier.compliance_evidences.find(params[:id])
  end
end
