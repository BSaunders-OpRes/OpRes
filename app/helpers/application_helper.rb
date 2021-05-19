module ApplicationHelper
  attr_reader :organisational_unit
  attr_reader :managing_unit

  def new_or_create
    params[:action].in? %w[new create]
  end

  def organisation_dropdown_options
    childs = organisational_unit.inclusive_children
    childs = Unit.sort_children(childs)
    childs.pluck(:name, :id)
  end

  def determine_user_redirect_path
    if current_user&.app_admin?
      admin_dashboard_index_path
    elsif current_user&.org_admin?
      current_user.sign_in_count > 1 ? organisation_dashboard_index_path : organisation_journey_path('welcome')
    elsif current_user&.unit_admin?
      organisation_dashboard_index_path
    else
      root_path
    end
  end

  def hide_search_bar?
    params[:controller] == 'organisation/journeys'
  end

  def hide_side_bar?
    params[:controller] == 'organisation/journeys'
  end

  def find_region(bsl)
    return {} unless @bsl.persisted?
    {} unless bsl.unit.institution_unit?
    [bsl.unit.parent.parent.name, bsl.unit.parent.parent.id ]
  end

  def find_country(bsl)
    return {} unless @bsl.persisted?
    {} unless bsl.unit.institution_unit?
    [bsl.unit.parent.name, bsl.unit.parent.id]
  end

  def find_institute(bsl)
    return {} unless @bsl.persisted?
    {} unless bsl.unit.institution_unit?
    [bsl.unit.name, bsl.unit.id]
  end
end
