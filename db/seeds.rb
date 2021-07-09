require 'json'

# Application Admin #
user = User.create_with(first_name: 'Application', last_name: 'Admin', password: 'Adm!n123', role: User.roles[:application_admin]).find_or_create_by(email: 'admin@opres.uk')
# user.confirm
# Application Admin #

# Import Regions and Countries #
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
# Import Regions and Countries #

# Import Institutions, Products, and Channels#
ipcs_file = Rails.root.join('public', 'json_data', 'institutions.json')
ipcs_data = File.read(ipcs_file)
JSON.parse(ipcs_data).each do |unit_type_data|
  unit_type_data.each do |unit_type, institutions_data|
    institutions_data.each do |institution_data|
      institution_data.each do |institution_name, pc_data|
        pre_institution = PreInstitution.create_with(description: institution_name).find_or_create_by(name: institution_name, unit_type: unit_type)

        pre_products = []
        pc_data.dig('products').each do |product|
          pre_product   = PreProduct.create_with(description: product).find_or_create_by(name: product)
          pre_products << pre_product

          pre_channels = []
          pc_data.dig('channels').each do |channel|
            pre_channels << PreChannel.create_with(description: channel).find_or_create_by(name: channel)
          end
          pre_product.pre_channel_ids = pre_channels.map(&:id)
        end
        pre_institution.pre_product_ids = pre_products.map(&:id)
      end
    end
  end
end
# Import Institutions, Products, and Channels#

# Import Social Accounts #
social_accounts_file = Rails.root.join('public', 'json_data', 'social_accounts.json')
social_account_data  = File.read(social_accounts_file)
JSON.parse(social_account_data).each do |name, data|
  social_account = SocialAccount.find_or_initialize_by(name: data.dig('name'))
  next if social_account.persisted?

  social_account.logo.attach(
    io:           File.open(Rails.root.join(data.dig('logo'))),
    filename:     data.dig('filename'),
    content_type: data.dig('content_type')
  )
  social_account.save
end
# Import Social Accounts #

# Import Cloud Hosting Providers, Regions, and Services #
cloud_hosting_provider_file = Rails.root.join('public', 'json_data', 'cloud_hosting_providers.json')
cloud_hosting_provider_data = File.read(cloud_hosting_provider_file)
JSON.parse(cloud_hosting_provider_data).each do |data|
  data.each do |chp_name, chp_data|
    chp = CloudHostingProvider.create_with(description: chp_name, short_name: chp_data['short_name']).find_or_create_by(name: chp_name)

    if chp.logo.blank?
      chp.logo.attach(
        io:           File.open(Rails.root.join(chp_data.dig('logo'))),
        filename:     chp_data.dig('filename'),
        content_type: chp_data.dig('content_type')
      )
    end

    chp_data.dig('regions').each do |region|
      chp.cloud_hosting_provider_regions.find_or_create_by(name: region)
    end

    chp_data.dig('services').each do  |service|
      chp.cloud_hosting_provider_services.find_or_create_by(name: service)
    end
  end
end
# Import Cloud Hosting Providers, Regions, and Services #

# Import Currencies #
currencies_file = Rails.root.join('public', 'json_data', 'currencies.json')
currencies_data = File.read(currencies_file)
JSON.parse(currencies_data).each do |country_alpha2, currencies|
  country = Country.find_by(alpha2: country_alpha2)
  next if country.blank?

  country_currencies = []
  currencies.each do |currency|
    country_currencies << Currency.create_with(currency).find_or_create_by(code: currency['code'])
  end

  country.currencies = country_currencies
end
# Import Currencies #
