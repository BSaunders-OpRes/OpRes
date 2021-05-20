namespace :countries do
  desc 'Export countries from Countries Gem to JSON file.'
  desc 'This task needs Countries Gem in order to execute.'
  desc 'No need to run this rake task again. The Countries Gem data is already exported to public/countries/original.json file. And final data is present in public/countries/modified.json after making the required modifications.'
  desc 'If there is a need to run this rake task again. Then after running it copy only the required changes to public/countries/modified.json. Do not override public/countries/modified.json as it already had some modifications.'
  task export: :environment do
    countries = []

    ISO3166::Country.all.map(&:world_region).uniq&.each do  |region|
      countries << {
        region => ISO3166::Country.find_all_countries_by_world_region(region).sort_by(&:name).map(&:data)
      }
    end

    file = Rails.root.join('public', 'countries', 'original.json')
    File.open(file, 'w') do |f|
      f.write(JSON.pretty_generate(countries))
    end
  end
end
