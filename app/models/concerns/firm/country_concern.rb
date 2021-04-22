module Firm::CountryConcern
  extend ActiveSupport::Concern

  included do
    class << self
      def regions
        ISO3166::Country.all.map(&:continent).uniq
      end

      def countries_by_continent(continent)
        ISO3166::Country.find_all_countries_by_continent(continent)
      end

      def countries_selection_by_continent(continent)
        countries_by_continent(continent).map { |c| [c.name, c.alpha2] }
      end
    end
  end
end
