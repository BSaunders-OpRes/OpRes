class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_application_admin?

  layout 'admin'

  private

  def is_application_admin?
    redirect_to root_path, alert: 'Access Denied!' unless current_user.application_admin?
  end
end
