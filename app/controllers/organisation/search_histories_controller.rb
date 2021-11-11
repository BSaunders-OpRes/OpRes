class Organisation::SearchHistoriesController < Organisation::BaseController
  def index
    @search_histories = current_user.search_histories.order(id: :desc)
    render json: @search_histories
  end

  def create
    @search_history = current_user.search_histories.create(title: params.dig(:key), url: params.dig(:url))
    render json: { message: "History create successfully" }, status: :ok
  end
end
