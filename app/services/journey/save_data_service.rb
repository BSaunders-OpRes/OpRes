class Journey::SaveDataService < ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    if args.dig(:params, :organisation_step).present?
      Journey::SaveOrganisationService.call(args)
    elsif args.dig(:params, :region_step).present?
      Journey::SaveRegionService.call(args)
    elsif args.dig(:params, :country_step).present?
      Journey::SaveCountryService.call(args)
    elsif args.dig(:params, :institution_step).present?
      Journey::SaveInstitutionService.call(args)
    elsif args.dig(:params, :user_step).present?
      Journey::SaveUserService.call(args)
    end

    args[:organisational_unit] = args.dig(:organisational_unit).include_children
    args.dig(:organisational_unit).update_units_status
  end
end
