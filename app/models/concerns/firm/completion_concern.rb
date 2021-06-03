module Firm::CompletionConcern
  extend ActiveSupport::Concern

  included do
    def update_units_status
      reload
      update_institution_units_status
      update_country_units_status
      update_regional_units_status
    end

    def update_institution_units_status
      institutional_units = find_children_by_type(:institution_unit)
      institutional_units = Units::Institution.includes(unit_products: [:unit_product_channels]).where(id: institutional_units.map(&:id))

      inprogress_units = []

      institutional_units.each do |institutional_unit|
        if institutional_unit.unit_products.blank?
          inprogress_units << institution_unit.id
          next
        end

        institutional_unit.unit_products.each do |unit_product|
          next if unit_product.unit_product_channels.present?

          inprogress_units << institutional_unit.id
          break
        end
      end

      Units::Institution.where(id: inprogress_units).update_all(status: Unit.statuses[:inprogress])
      Units::Institution.where(id: (institutional_units.map(&:id) - inprogress_units)).update_all(status: Unit.statuses[:completed])
    end

    def update_country_units_status
      country_units = find_children_by_type(:country_unit)
      country_units = Units::Country.includes(:children).where(id: country_units.map(&:id))

      incomplete_units, inprogress_units, completed_units = [], [], []

      country_units.each do |country_unit|
        if country_unit.children.blank?
          incomplete_units << country_unit.id
        elsif country_unit.children.reject(&:completed?).size.positive?
          inprogress_units << country_unit.id
        else
          completed_units << country_unit.id
        end
      end

      Units::Country.where(id: incomplete_units).update_all(status: Unit.statuses[:incomplete])
      Units::Country.where(id: inprogress_units).update_all(status: Unit.statuses[:inprogress])
      Units::Country.where(id: completed_units).update_all(status: Unit.statuses[:completed])
    end

    def update_regional_units_status
      regional_units = find_children_by_type(:regional_unit)
      regional_units = Units::Regional.includes(:children).where(id: regional_units.map(&:id))

      incomplete_units, inprogress_units, completed_units = [], [], []

      regional_units.each do |regional_unit|
        if regional_unit.children.blank?
          incomplete_units << regional_unit.id
        elsif regional_unit.children.reject(&:completed?).size.positive?
          inprogress_units << regional_unit.id
        else
          completed_units << regional_unit.id
        end
      end

      Units::Regional.where(id: incomplete_units).update_all(status: Unit.statuses[:incomplete])
      Units::Regional.where(id: inprogress_units).update_all(status: Unit.statuses[:inprogress])
      Units::Regional.where(id: completed_units).update_all(status: Unit.statuses[:completed])
    end
  end
end
