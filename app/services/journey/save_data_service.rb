class Journey::SaveDataService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    if args.dig(:params, :organisation).present?
      Journey::SaveOrganisationService.call(args)
    elsif args.dig(:params, :regions).present?
      Journey::SaveRegionService.call(args)
    elsif args.dig(:params, :countries).present?
      Journey::SaveCountryService.call(args)
    elsif args.dig(:params, :institutions).present?
      Journey::SaveInstitutionService.call(args)
    elsif args.dig(:params, :users).present?
      Journey::SaveUserService.call(args)
    end

    args[:organisational_unit] = args.dig(:organisational_unit).include_children
    args.dig(:organisational_unit).update_units_status
  end
end
