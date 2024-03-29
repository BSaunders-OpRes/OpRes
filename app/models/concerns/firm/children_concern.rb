module Firm::ChildrenConcern
  extend ActiveSupport::Concern

  included do
    def include_children
      Unit.includes(children: [children: [:children]]).find(id)
    end

    def include_deep_children
      Unit.includes(children: [children: [children: [unit_products: [:unit_product_channels]]]]).find(id)
    end

    def inclusive_children
      include_children.exclusive_children.unshift(self)
    end

    def exclusive_children
      children.flat_map do |child|
        child.exclusive_children << child
      end
    end

    def find_children(child_id)
      inclusive_children.select { |child| child.id == child_id.to_i }.first
    end

    def find_children_by_region(region_id)
      inclusive_children.select { |child| child.region_id == region_id.to_i }.first
    end

    def find_children_by_country(country_id)
      inclusive_children.select { |child| child.country_id == country_id.to_i }.first
    end

    def find_children_by_type(type)
      inclusive_children.select { |child| child.send("#{type.to_s}?")}
    end

    def sort_children_rule
      case type
      when 'Units::Organisational'
        0
      when 'Units::Regional'
        1
      when 'Units::Country'
        2
      when 'Units::Institution'
        3
      end
    end

    class << self
      def sort_children(children_nodes)
        children_nodes.sort_by(&:sort_children_rule)
      end
    end
  end
end
