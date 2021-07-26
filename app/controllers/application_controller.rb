class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.organisation_dashboard_index_path, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
end
