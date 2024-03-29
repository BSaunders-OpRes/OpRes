class Organisation::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_organisation_users
  before_action :load_organisational_unit
  before_action :load_managing_units

  attr_reader   :organisational_unit
  attr_reader   :managing_units
  attr_accessor :root_users

  layout 'organisation'

  private

  # Organisation Namespace Data Loaders #
  def authenticate_organisation_users
    redirect_to root_path, alert: 'Access Denied!' if current_user.application_admin?
  end

  def load_organisational_unit
    @organisational_unit = current_user.unit.include_children
  end

  def load_managing_units
    @managing_units = current_user.managing_units
  end

  def organisatial_root_user
    @root_users = organisational_unit.users&.root_user
  end
  # Organisation Namespace Helpers #
  def authenticate_root_user
    redirect_to organisation_dashboard_index_path, alert: 'Access Denied!' unless current_user.root_user?
  end

  def managing_nodes
    @managing_nodes ||= @managing_units.map(&:inclusive_children).flatten.map(&:id)
  end

  def managing_country_units
    @managing_country_units ||= Units::Country.joins(:parent).where(parents_units: { id: managing_units.map(&:id) })
  end

  def managing_institution_units
    @managing_institution_units ||= Units::Institution.joins(parent: [:parent]).where(parents_units_2: { id: managing_units.map(&:id) })
  end
end
