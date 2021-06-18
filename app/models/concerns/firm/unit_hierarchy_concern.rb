module Firm::UnitHierarchyConcern
  extend ActiveSupport::Concern

  included do
    # What to populate in the dropdown/checkboxe. #
    def self.regional_unit_dropdown(managing_units)
      managing_units.map { |managing_unit| [managing_unit.name, managing_unit.id] }
    end

    def country_unit_dropdown
      if organisational_unit?
        []
      elsif regional_unit?
        children.map { |c| [c.name, c.id] }
      else
        []
      end
    end

    def institution_unit_dropdown
      if organisational_unit? || regional_unit?
        []
      elsif country_unit?
        children.map { |c| [c.name, c.id] }
      else
        []
      end
    end

    def products_checkboxes
      unit_level_products.distinct.map { |product| [product.name, product.id] }
    end

    def channels_checkboxes
      unit_product_ids  = unit_products.ids
      distinct_channels = Channel.joins(unit_product_channels: [:unit_product]).where(unit_products: { id: unit_product_ids }).distinct
      distinct_channels.map { |channel| [channel.name, channel.id] }
    end

    # What to select in the dropdown. #
    def selected_regional_unit
      if regional_unit?
        self
      elsif parent&.regional_unit?
        parent
      elsif parent&.parent&.regional_unit?
        parent.parent
      end
    end

    def selected_country_unit
      if country_unit?
        self
      elsif parent&.country_unit?
        parent
      end
    end

    def selected_institution_unit
      self if institution_unit?
    end
  end
end
