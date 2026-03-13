require_relative 'boot'
require 'rails/all'

module UrlShortener
  class Application < Rails::Application
    config.load_defaults 7.1
    config.eager_load = false
  end
end

