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
      organisation_dashboard_index_path
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

  def name_initials
    first_name = @current_user.first_name
    last_name  = @current_user.last_name

    if first_name.present? && last_name.present?
      first_name[0] + last_name[0]
    elsif first_name.present? && last_name.blank?
      first_name[0] + first_name[1]
    elsif first_name.blank? && last_name.present?
      last_name[0] + last_name[1]
    else
      ""
    end
  end

  def full_name
    @current_user.first_name + " " + @current_user.last_name
  end
end
