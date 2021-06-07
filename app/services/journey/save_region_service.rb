class Journey::SaveRegionService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    final_regional_units = []

    args.dig(:params, :regions)&.each do |id, name|
      regional_unit = args.dig(:organisational_unit)
                          .children
                          .create_with(type: Units::Regional, name: Unit.build_name('', args.dig(:organisational_unit).name, name))
                          .find_or_create_by(region_id: id)
      final_regional_units << regional_unit.id
    end

    regional_units_to_destroy = args.dig(:organisational_unit).children.map(&:id) - final_regional_units
    Units::Regional.where(id: regional_units_to_destroy).destroy_all
  end
end
