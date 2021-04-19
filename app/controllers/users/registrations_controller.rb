# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.role = User.roles[:org_admin]
    resource.units.build(organisation_params)

    begin
      resource.save
    rescue => e
      if e.instance_of? ActiveRecord::RecordNotUnique
        resource.errors.add(:base, 'Email is already taken.')
      else
        resource.error.add(:base, 'Oops! something went wrong.')
      end
    end

    yield resource if block_given?

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with(resource) do |format|
          format.json { render json: { data: resource }, status: 200 }
        end
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, data: resource, status: 200
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      msg = resource.errors.full_messages.join("<br>").html_safe
      respond_with(resource) do |format|
        format.json { render json: { message: msg }, status: 401 }
      end
    end
  end

  private

  def organisation_params
    params.require(:organisation).permit(:name, :unit_type).merge(type: 'Units::Organisational')
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
