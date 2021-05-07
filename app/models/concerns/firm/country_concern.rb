module Firm::CountryConcern
  extend ActiveSupport::Concern

  included do
    class << self
      def regions
        ISO3166::Country.all.map(&:world_region).uniq << 'LATAM'
      end

      def countries_by_region(region)
        countries_objects_by_region(region).map(&:name)
      end

      def countries_objects_by_region(region)
        ISO3166::Country.find_all_countries_by_world_region(region)
      end

      def countries_selection_by_region(region)
        countries_objects_by_region(region).map      { |c| [c.name, c.alpha2] }
                                           .group_by { |c| c[0][0].upcase }
                                           .sort_by  { |k, v| k }
      end

      def find_country_by_code(code)
        ISO3166::Country.find_country_by_alpha2(code)
      end
    end
  end
end
