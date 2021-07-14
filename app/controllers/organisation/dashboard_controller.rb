class Organisation::DashboardController < Organisation::BaseController
  before_action :load_graph, only: %i[show]

  def index; end

  def show; end

  private

  def load_graph
    @graph = params[:id]
  end
end
