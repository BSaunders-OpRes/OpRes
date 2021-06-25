class Organisation::StepsController < Organisation::BaseController
  before_action :load_step, only: %i[destroy supplier_step]

  def destroy
    respond_to do |format|
      if @step&.destroy
        format.json { render json: { deleted: true } }
      else
        format.json { render json: { deleted: false } }
      end
    end
  end

  def supplier_step
    supplier_steps = SupplierStep.where(step_id: @step&.id, supplier_id: params[:supplier_id])

    respond_to do |format|
      if supplier_steps.destroy_all
        format.json { render json: { deleted: true } }
      else
        format.json { render json: { deleted: false } }
      end
    end
  end

  private

  def load_step
    @step = Step.joins(business_service_line: [:unit])
                .where(units: { id: managing_nodes })
                .find_by(id: params[:id])
  end
end
