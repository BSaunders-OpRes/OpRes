class Graphs::BaseService < ApplicationService
  def initialize(args)
    @args                = args
    @current_user        = args&.dig('current_user')
    @organisational_unit = args&.dig('organisational_unit')

    @data = {}
  end

  def find_score_and_status_for_percentage(bsl_point,  supplier_point, impact_tolerance_point)
    if(supplier_point == bsl_point || supplier_point > bsl_point)
      %w(10 match)
    elsif (supplier_point < bsl_point && supplier_point >= impact_tolerance_point)
      %w(5 meet)
    elsif (supplier_point < impact_tolerance_point)
      %w(0 exceed)
    end
  end

  def find_score_and_status_for_time(bsl_point,  supplier_point, impact_tolerance_point)
    if (supplier_point == bsl_point || supplier_point <= bsl_point)
      %w(10 match)
    elsif (supplier_point > bsl_point && (supplier_point <= impact_tolerance_point && supplier_point > bsl_point))
      %w(5  meet)
    elsif (supplier_point > impact_tolerance_point)
      %w(0 exceed)
    end
  end

  def filter_data
    nodes = []
    if args.dig("filters").present?
      if args.dig("filters","region_ids").present?
        nodes << (args.dig("filters","region_ids").include?('all') ? organisational_unit.inclusive_children.select { |a| a.type == "Units::Regional" } : organisational_unit.inclusive_children.select { |a| a.type == "Units::Regional" && args.dig("filters","region_ids").include?(a.region_id.to_s)}).map(&:id)
      end
      if args.dig("filters","country_ids").present?
        nodes << (args.dig("filters","country_ids").include?('all') ? organisational_unit.inclusive_children.select { |a| a.type == "Units::Country" } : organisational_unit.inclusive_children.select { |a| a.type == "Units::Country" && args.dig("filters","country_ids").include?(a.country_id.to_s)}).map(&:id)
      end
      if args.dig("filters","sub_region_ids").present?
        nodes << (args.dig("filters","sub_region_ids").include?('all') ? organisational_unit.inclusive_children.select { |a| a.type == "Units::Country" } : organisational_unit.inclusive_children.select { |a| a.type == "Units::Country" && args.dig("filters","sub_region_ids").include?(a.country_id.to_s)}).map(&:id)
      end
      if args.dig("filters","institution_ids").present?
        nodes << (args.dig("filters","institution_ids").include?('all') ? organisational_unit.inclusive_children.select { |a| a.type == "Units::Institution" } : organisational_unit.inclusive_children.select { |a| a.type == "Units::Institution" && args.dig("filters","institution_ids").include?(a.institution_id.to_s)}).map(&:id)
      end
      if args.dig("filters","product_ids").present?
        nodes << (args.dig("filters","product_ids").include?('all') ? organisational_unit.products : organisational_unit.products.select { |a| args.dig("filters","product_ids").include?(a.id.to_s)}).map(&:unit_id)
      end
      # if args.dig("filters","entity_ids").present?
      #   nodes << (args.dig("filters","entity_ids").include?('all') ? organisational_unit.products : organisational_unit.products.select { |a| args.dig("filters","entity_ids").include?(a.id.to_s)}).map(&:unit_id)
      # end
    else
      nodes << organisational_unit.inclusive_children.map(&:id)
    end
    nodes.flatten
  end

  attr_reader :current_user, :organisational_unit, :data
end
