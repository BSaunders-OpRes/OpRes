class Organisation::DashboardController < Organisation::BaseController
  before_action :load_graph, only: %i[show]
  before_action :managing_country_units, only: %i[index]

  def index
  end

  def show; end

  private

  def load_graph
    @graph = params[:id]
  end
end
