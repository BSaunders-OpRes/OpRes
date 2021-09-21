class Organisation::GraphsController  < Organisation::BaseController
  def compose
    service = "Graphs::#{params[:key].titleize.delete(' ')}Service".constantize
    args    = {
      current_user:        current_user,
      organisational_unit: organisational_unit,
      filters:             (params[:filters] || ActionController::Parameters.new).permit!.to_h,
    }.merge((params[:args] || ActionController::Parameters.new).permit!.to_h)
    @data = service.call(args.stringify_keys)
  end
end
