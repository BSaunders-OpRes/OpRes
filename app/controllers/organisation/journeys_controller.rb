class Organisation::JourneysController < Organisation::BaseController
  def index; end

  def regional_step
    @organisational_unit.update(organisation_params)
    respond_to do |format|
      format.js
      format.html
    end
  end

  def country_step
  end

  def institution_step
  end

  def product_step
  end

  def channel_step
  end

  private

  def organisation_params
    params.require(:units_organisational).permit(:name)
  end

  def finish_wizard_path
    # user_path(current_user)
  end
end
