# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  respond_to :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    Rails.logger.info "*"*50
    Rails.logger.info "Tenant: #{Apartment::Tenant.current}"
    Rails.logger.info "Session User: #{session['warden.user.user.key']}"
    Rails.logger.info "Current User: #{current_user&.inspect}"
    Rails.logger.info "Request Referrer: #{request&.referrer}"
    Rails.logger.info "Request URL: #{request&.url}"
    Rails.logger.info "*"*50
    respond_with(resource) do |format|
      format.json { render json: { redirect_url: after_sign_in_path_for(resource) }, status: 200 }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def after_sign_in_path_for(resource)
    if resource.app_admin?
      admin_dashboard_index_path
    else
      root_path
    end
  end
end
