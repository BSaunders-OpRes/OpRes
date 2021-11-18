class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :load_notifications

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.organisation_dashboard_index_path, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def load_notifications
    return nil if current_user.blank?
    
    @unviewed_notifications = current_user.user_notifications.where(viewed: false)
    @viewed_notifications = current_user.user_notifications.where(viewed: true)
  end
end
