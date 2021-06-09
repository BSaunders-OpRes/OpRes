class Organisation::GraphsController  < Organisation::BaseController
  before_action :load_graph, only: %i[show]

  def show; end

  private

  def load_graph
    @graph = params[:id]
  end
end
