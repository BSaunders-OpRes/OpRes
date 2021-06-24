class Organisation::StepsController < Organisation::BaseController
  before_action :load_step, only: %[destroy]

  def destroy
    respond_to do |format|
      if @step&.destroy
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
