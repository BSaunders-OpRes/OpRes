require 'json'

# Application Admin #
user = User.create_with(first_name: 'Application', last_name: 'Admin', password: 'Adm!n123', role: User.roles[:app_admin]).find_or_create_by(email: 'admin@opres.uk')
# user.confirm
# Application Admin #

# Institutions #
%w[Retail\ Bank Business\ Bank Commercial\ Bank Investment\ Bank Union\ Bank Wealth\ Management].each do |institution|
  PreInstitution.create_with(description: institution).find_or_create_by(name: institution)
end
# Institutions #

# Products #
%w[Current\ Account Mortgages Loans Credit\ Cards Savings\ Accounts Checking\ Account Treasury\ Service Payment\ Processing Securities Mergers\ &\ Acqusition Fixed\ Income Foreign\ Exchange Underwriting Derivative Equity Comodity].each do |product|
  PreProduct.create_with(description: product).find_or_create_by(name: product)
end
# Products #

# Channels #
%w[Web Mobile ATM Branch Telephony].each do |channel|
  PreChannel.create_with(description: channel).find_or_create_by(name: channel)
end
# Channels #

# Import Countries #
countries_file = Rails.root.join('public', 'json_data', 'countries.json')
countries_data = File.read(countries_file)
JSON.parse(countries_data).each do |region_with_countries|
  region_with_countries.each do |region, countries|
    region = Region.find_or_create_by(name: region)
    countries.each do |country|
      region.countries.create_with(
        continent:    country.dig('continent'),
        alpha3:       country.dig('alpha3'),
        country_code: country.dig('country_code'),
        international_prefix: country.dig('international_prefix'),
        ioc:  country.dig('ioc'),
        gec:  country.dig('gec'),
        name: country.dig('name'),
        national_destination_code_lengths: country.dig('national_destination_code_lengths'),
        national_number_lengths: country.dig('national_number_lengths'),
        national_prefix: country.dig('national_prefix'),
        number:          country.dig('number'),
        region_name:     country.dig('region_name'),
        subregion:       country.dig('subregion'),
        world_region:    country.dig('world_region'),
        un_locode:       country.dig('un_locode'),
        nationality:     country.dig('nationality'),
        postal_code:     country.dig('postal_code'),
        postal_code_format: country.dig('postal_code_format'),
        unofficial_names:   country.dig('unofficial_names'),
        languages_official: country.dig('languages_official'),
        languages_spoken:   country.dig('languages_spoken'),
        geo:                country.dig('geo'),
        currency_code:      country.dig('currency_code'),
        start_of_week:      country.dig('start_of_week'),
        translations:       country.dig('translations'),
        translated_names:   country.dig('translated_names')
      )
      .find_or_create_by(alpha2: country.dig('alpha2'))
    end
  end
end
# Import Countries #
