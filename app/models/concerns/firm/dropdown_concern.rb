module Firm::DropdownConcern
  extend ActiveSupport::Concern

  included do
    def can_access_regional_dropdown?
      organisational_unit?
    end

    def can_access_country_dropdown?
      organisational_unit? || regional_unit?
    end

    def can_access_institution_dropdown?
      organisational_unit? || regional_unit? || country_unit?
    end

    def regional_dropdown
      if organisational_unit?
        children.map { |c| [c.name, c.id] }
      else
        []
      end
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
