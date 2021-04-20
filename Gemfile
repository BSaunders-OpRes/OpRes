source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'apartment', github: 'influitive/apartment', branch: 'development'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'carmen-rails', '~> 1.0.0'
gem 'devise'
gem 'jbuilder', '~> 2.7'
gem 'pg', '>=1.2.3'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.6'
gem 'react-rails', '~> 2.6.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'brakeman', '~> 5.0.0'
  gem 'listen', '~> 3.2'
  gem 'rspec-rails', '~> 5.0.1'
  gem 'rubocop', '~> 1.12.1', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
