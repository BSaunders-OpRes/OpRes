class Admin::BaseController < ApplicationController
  before_action :log_info
  before_action :authenticate_user!
  before_action :is_admin?

  layout 'admin'

  private

  def log_info
    Rails.logger.info "*"*50
    Rails.logger.info "Tenant: #{Apartment::Tenant.current}"
    Rails.logger.info "Session User: #{session['warden.user.user.key']}"
    Rails.logger.info "Current User: #{current_user&.inspect}"
    Rails.logger.info "Request Referrer: #{request&.referrer}"
    Rails.logger.info "Request URL: #{request&.url}"
    Rails.logger.info "*"*50
  end

  def is_admin?
    redirect_to root_path, alert: 'Access Denied!' unless current_user.app_admin?
  end
end
