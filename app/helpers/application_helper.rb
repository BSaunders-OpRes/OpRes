module ApplicationHelper
  attr_reader :organisational_unit

  def new_or_create
    params[:action].in? %w[new create]
  end
end
