class Journey::SaveOrganisationService <  ApplicationService
  def initialize(args = {})
    @args = args
  end

  def call
    args.dig(:organisational_unit).update(name: args.dig(:params, :organisation, :name))
  end
end
