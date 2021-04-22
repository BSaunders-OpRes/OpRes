class AuthenticationController < ApplicationController
  def index
    redirect_to admin_dashboard_index_path, alert: 'You are already singed_in.' if current_user.present?
  end

  def sign_in
    user = User.find_by(email: params[:user][:email])

    if user.present? && User.valid_password?(params[:user][:password], user.encrypted_password) && user.app_admin?
      bypass_sign_in(user)
      redirect_url, message, status = admin_dashboard_index_path, 'Signed in successfully!', 200
    else
      redirect_url, message, status = authentication_index_path, 'Invalid email or password!', 401
    end

    respond_to do |format|
      format.json { render json: { redirect_url: redirect_url, message: message }, status: status }
    end
  end

  def sign_out
    if current_user.present?
      reset_session
      @current_user = nil
    end

    redirect_to authentication_index_path
  end
end
