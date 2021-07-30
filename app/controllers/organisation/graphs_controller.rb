class Organisation::GraphsController  < Organisation::BaseController
  before_action :get_version

  def compose
    service = "Graphs::#{params[:key].titleize.delete(' ')}Service".constantize
    args    = {
      current_user:        current_user,
      organisational_unit: organisational_unit
    }.merge((params[:args] || ActionController::Parameters.new).permit!.to_h)
    @data   = service.call(args.stringify_keys)
  end

  def get_version
    @version = params.dig(:args, :version)
  end
end
