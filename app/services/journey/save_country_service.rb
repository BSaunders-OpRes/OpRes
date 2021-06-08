class Journey::SaveCountryService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    final_country_units = []

    args.dig(:params, :countries)&.each do |id, name|
      country_unit = args.dig(:regional_unit)
                         .children
                         .create_with(type: Units::Country, name: Unit.build_name('', args.dig(:organisational_unit).name, name))
                         .find_or_create_by(country_id: id)
      final_country_units << country_unit.id
    end

    country_units_to_destroy = args.dig(:regional_unit).children.map(&:id) - final_country_units
    Units::Country.where(id: country_units_to_destroy).destroy_all
  end
end
