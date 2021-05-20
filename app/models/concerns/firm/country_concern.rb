module Firm::CountryConcern
  extend ActiveSupport::Concern

  included do
    class << self
      def regions
        Region.all.map(&:name).uniq
      end

      def countries_by_region(region)
        countries_objects_by_region(region).map(&:name)
      end

      def countries_objects_by_region(region)
        Region.find_by_name(region).countries.sort_by(&:name)
      end

      def countries_selection_by_region(region)
        countries_objects_by_region(region).map      { |c| [c.name, c.alpha2] }
                                           .group_by { |c| c[0][0].upcase }
                                           .sort_by  { |k, v| k }
      end

      def find_country_by_code(code)
        Country.find_by_alpha2(code)
      end
    end
  end
end
