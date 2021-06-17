module Firm::DropdownConcern
  extend ActiveSupport::Concern

  included do

    def self.regional_dropdown(managing_units)
      managing_units.map{ |managing_unit| [managing_unit.name, managing_unit.id] }
    end

    def country_dropdown
      if organisational_unit?
        []
      elsif regional_unit?
        children.map { |c| [c.name, c.id] }
      else
        []
      end
    end

    def institution_dropdown
      if organisational_unit? || regional_unit?
        []
      elsif country_unit?
        children.map { |c| [c.name, c.id] }
      else
        []
      end
    end
  end
end
