class Organisation::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_organisation_users
  before_action :load_organisational_unit

  attr_reader :organisational_unit

  layout 'organisation'

  private

  def authenticate_organisation_users
    redirect_to root_path, alert: 'Access Denied!' unless current_user.org_admin? || current_user.unit_admin?
  end

  def authenticate_org_admin
    redirect_to organisation_dashboard_index_path, alert: 'Access Denied!' unless current_user.org_admin?
  end

  def load_organisational_unit
    @organisational_unit = current_user.unit.include_children
  end
end