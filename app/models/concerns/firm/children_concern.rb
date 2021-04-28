module Firm::ChildrenConcern
  extend ActiveSupport::Concern

  included do
    def include_children
      Unit.includes(children: [children: [:children]]).find(id)
    end

    def inclusive_children
      exclusive_children.unshift(self)
    end

    def exclusive_children
      children.flat_map do |child|
        child.exclusive_children << child
      end
    end

    def find_children(child_id)
      inclusive_children.select { |child| child.id == child_id }.first
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
