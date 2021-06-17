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
    if current_user&.application_admin?
      admin_dashboard_index_path
    elsif current_user&.root_user?
      organisation_dashboard_index_path
    elsif current_user.super_or_standard_user?
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
    return {} unless bsl.persisted?
    {} unless bsl.unit.institution_unit?
    [bsl.unit.parent.name, bsl.unit.parent.id]
  end

  def all_countries_from_region(bsl)
    return {} unless bsl.persisted?
    bsl_region = bsl.unit.parent.parent
    bsl_region.children.map{|country| [country.name, country.id]}
  end

  def all_institution_from_country(bsl)
    return {} unless bsl.persisted?
    bsl_country = bsl.unit.parent
    bsl_country.children.map{ |institution| [institution.name, institution.id]}
  end

  def all_products_from_institution(bsl)
    return {} unless bsl.persisted?
    products = bsl.unit.unit_level_products.distinct
    products.map{|product| [product.name, product.id]}
  end

  def all_channels_from_product(bsl)
    return {} unless bsl.persisted?
    channels = Channel.joins(unit_product_channels: [:unit_product]).where(unit_products: { id: bsl.unit.unit_products.ids }).distinct
    channels.map{|channel| [channel.name, channel.id]}
  end

  def find_institute(bsl)
    return {} unless @bsl.persisted?
    {} unless bsl.unit.institution_unit?
    [bsl.unit.name, bsl.unit.id]
  end

  def find_supplier_region(supplier)
    return {} unless supplier.persisted?
    [supplier.unit.parent.name, supplier.unit.parent.id]
  end

  def find_supplier_country(supplier)
    return {} unless supplier.persisted?
    [supplier.unit.name, supplier.unit.id]
  end


  def supplier_find_country(supplier)
    return {} unless supplier.persisted?
    supplier_region = supplier.unit.parent
    supplier_region.children.map{|country| [country.name, country.id]}
  end

  # need to remove after updating supplier form on BSL.
  def find_suppliers
    unit_children_ids = organisational_unit.inclusive_children.map(&:id)
    Supplier.where(unit_id: unit_children_ids)
  end
end
