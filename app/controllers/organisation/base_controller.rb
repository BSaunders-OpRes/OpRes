class Organisation::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :is_org_or_unit_admin?
  before_action :load_organisational_unit

  attr_reader :organisational_unit

  layout 'organisation'

  private

  def is_org_or_unit_admin?
    redirect_to root_path, alert: 'Access Denied!' unless current_user.org_admin? || current_user.unit_admin?
  end

  def load_organisational_unit
    @organisational_unit = current_user.unit
  end
end
