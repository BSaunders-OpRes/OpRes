require_relative 'boot'
require 'rails/all'
require 'dotenv'

Bundler.require(*Rails.groups)


module Opres
  class Application < Rails::Application
    config.load_defaults 6.0
    Dotenv.load
  end
end
