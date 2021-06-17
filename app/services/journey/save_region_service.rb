class Journey::SaveRegionService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    final_regional_units  = []
    managers              = []

    args.dig(:params, :regions)&.each do |id, name|
      regional_unit = args.dig(:organisational_unit)
                          .children
                          .find_or_initialize_by(region_id: id)

      if regional_unit.persisted?
        regional_unit.update(name: region_name(name))
      else
        regional_unit.update_attributes(type: Units::Regional, name: region_name(name))
        root_users.each do |root_user|
          managers << root_user.managers.find_or_initialize_by(unit_id: regional_unit.id)
        end
      end

      final_regional_units << regional_unit.id
    end

    Manager.import managers, on_duplicate_key_ignore: true

    regional_units_to_destroy = args.dig(:organisational_unit).children.map(&:id) - final_regional_units
    Units::Regional.where(id: regional_units_to_destroy).destroy_all
  end

  private

  def root_users
    @root_users = args.dig(:organisational_unit).users.root_user
  end

  def region_name(name)
    Unit.build_name('', args.dig(:organisational_unit).name, name)
  end
end
