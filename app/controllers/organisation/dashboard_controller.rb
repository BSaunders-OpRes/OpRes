class Organisation::DashboardController < Organisation::BaseController
  before_action :load_graph, only: %i[show]
  before_action :managing_country_units, only: %i[index]

  def index
  end

  def show; end

  def search
    search_data = Journey::SearchService.call({current_user: current_user, organisational_unit: @organisational_unit, filter: params.dig(:term)})
    render json: search_data
  end

  def filter_resilience_indicator
    args = {
      'current_user' =>  current_user,
      'organisational_unit' =>  organisational_unit,
      'filters' => (params[:filters] || ActionController::Parameters.new).permit!.to_h
    }

    @resilience_risk_indicator = Graphs::ResilienceRiskIndicatorService.new(args).call
  end

  private

  def load_graph
    @graph = params[:id]
  end
end
