class Organisation::ResilienceGapsController < Organisation::BaseController
  before_action :set_resilience_ticket, only: %i[new create update edit resilience_indicator_ticket save_assignee_user]

  def resilience_indicator_ticket
    @resilience_supplier            = @resilience_ticket.supplier
    @resilience_material_risk_taker = @resilience_bsl.material_risk_taker
    @resilience_audits              = @resilience_ticket.resilience_audits
    @recent_resilience_audit        = @resilience_ticket.resilience_audits.last
  end


  def new
    @resilience_audit = @resilience_ticket.resilience_audits.new
  end

  def create
    @recent_resilience_audit = @resilience_ticket.resilience_audits.new(resilence_params)
    @recent_resilience_audit.save
    @resilience_ticket.update(status: params[:resilience_audit][:resilience_ticket_status].to_i) if @recent_resilience_audit && params[:resilience_audit][:resilience_ticket_status].present?
    @resilience_audits = @resilience_ticket.resilience_audits
  end

  def edit
    @resilience_audit = @resilience_ticket.resilience_audits.find_by_id(params[:id])
  end

  def update
    @recent_resilience_audit        = @resilience_ticket.resilience_audits.find_by_id(params[:id])
    @recent_resilience_audit_status = @recent_resilience_audit.update(resilence_params)
    @recent_resilience_audit
  end

  def save_assignee_user
    @resilience_status = @resilience_ticket.update(user: User.find_by_id(params[:user]))
  end

  private

  def set_resilience_ticket
    @resilience_ticket = ResilienceTicket.find_by_id(params[:resilience_ticket_id])
    @resilience_bsl    = @resilience_ticket.business_service_line
  end

  def resilence_params
    params.require(:resilience_audit).permit(:description, :attachment)
  end
end
