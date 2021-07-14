class Organisation::GraphsController  < Organisation::BaseController
  def compose
    service = "Graphs::#{params[:key].titleize.delete(' ')}Service".constantize
    @data   = service.call(params[:args].permit!.to_h)
  end
end
