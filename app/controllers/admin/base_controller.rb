class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_app_admin?

  layout 'admin'

  private

  def is_app_admin?
    redirect_to root_path, alert: 'Access Denied!' unless current_user.app_admin?
  end
end
